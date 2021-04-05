Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC913545B2
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Apr 2021 18:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhDEQwS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Apr 2021 12:52:18 -0400
Received: from icebox.esperi.org.uk ([81.187.191.129]:35906 "EHLO
        mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbhDEQwS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 5 Apr 2021 12:52:18 -0400
Received: from loom (nix@sidle.srvr.nix [192.168.14.8])
        by mail.esperi.org.uk (8.16.1/8.16.1) with ESMTP id 135Gq9TW003690;
        Mon, 5 Apr 2021 17:52:09 +0100
From:   Nix <nix@esperi.org.uk>
To:     "bfields\@fieldses.org" <bfields@fieldses.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs\@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        linux-net@vger.kernel.org
Subject: Re: steam-associated reproducible hard NFSv4.2 client hang (5.9, 5.10)
References: <877dourt7c.fsf@esperi.org.uk>
        <20210223225701.GD8042@fieldses.org>
        <fde7a43ac9b61a1aff53381d0ab7b48b78cb79db.camel@hammerspace.com>
        <20210224020140.GA26848@fieldses.org>
Emacs:  Our Lady of Perpetual Garbage Collection
Date:   Mon, 05 Apr 2021 17:52:09 +0100
In-Reply-To: <20210224020140.GA26848@fieldses.org> (bfields@fieldses.org's
        message of "Tue, 23 Feb 2021 21:01:40 -0500")
Message-ID: <87ft047jye.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-DCC--Metrics: loom 1480; Body=4 Fuz1=4 Fuz2=4
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

[linux-net added: a stubborn NFS client hang doing uncompression of some
 Steam games over NFS now looks like it might be TCP-stack or even
 network-device-related rather than NFS-related]

On 24 Feb 2021, bfields@fieldses.org said:

> On Tue, Feb 23, 2021 at 11:58:51PM +0000, Trond Myklebust wrote:
>> On Tue, 2021-02-23 at 17:57 -0500, J. Bruce Fields wrote:
>> > On Sun, Jan 03, 2021 at 02:27:51PM +0000, Nick Alcock wrote:
>> > > Relevant exports, from /proc/fs/nfs/exports:
>> > > 
>> > > /       192.168.16.0/24,silk.wkstn.nix(ro,insecure,no_root_squash,s
>> > > ync,no_wdelay,no_subtree_check,v4root,fsid=0,uuid=0a4a4563:00764033
>> > > :8c827c0e:989cf534,sec=390003:390004:390005:1)
>> > > /home/.loom.srvr.nix    *.srvr.nix,fold.srvr.nix(rw,root_squash,syn
>> > > c,wdelay,no_subtree_check,uuid=0a4a4563:00764033:8c827c0e:989cf534,
>> > > sec=1)
>> 
>> Isn't that trying to export the same filesystem as '/' on the line
>> above using conflicting export options?
>
> Yes, and exporting something on the root filesystem is generally a bad
> idea for the usual reasons.
>
> I don't see any explanation for the write hang there, though.
>
> Unless maybe if it leaves mountd unable to answer an upcall for some
> reason, hm.
>
> I think that would show up in /proc/net/rpc/nfsd.fh/content.  Try
> cat'ing that file after 'rpcdebug -m rpc -s cache' and that should show
> if there's an upcall that's not getting answered.

OK, I got some debugging: this is still happening on 5.11, but it's
starting to look more like a problem below NFS.

There are no unanswered upcalls, and though I did eventually manage to
get a multimegabyte pile of NFS debugging info (after fighting with the
problem that the Steam client has internal timeouts that are silently
exceeded and break things if you just leave debugging on)... I suspect I
don't need to bother you with it, because the packet capture was more
informative.

I have a complete capture of everything on the wire from the moment
Steam started, but it's nearly 150MiB xz'ed and includes a lot of boring
nonsense related to Steam's revalidation of everything because the last
startup crashed: it probably also includes things like my Steam account
password, getdents of my home directory etc so if you want that I can
send you the details privately: but this capture of only the last few
thousand NFS packets is interesting enough:
<http://www.esperi.org.uk/~nix/temporary/nfs-trouble.cap>.

Looking at this in Wireshark, everything goes fine (ignoring the usual
offloading-associated checksum whining) until packet 1644, when we
suddenly start seeing out-of-order packets and retransmissions (on an
otherwise totally idle 10GbE subnet). They get more and more common, and
at packet 1711 the client loses patience and hits the host with a RST.
This is... not likely to do NFS any good at all, and with $HOME served
over the same connection I'm not surprised the client goes fairly
unresponsive after that and the hangcheck timer starts screaming about
processes blocked on I/O to some of the odder filesystems I'm getting
over NFS on that client, like /var/tmp and /var/account/acct (so, yes,
all process termination likely blocks forever on this). So it looks like
NFS is being betrayed by TCP and/or some lower layer. (Also, NFS doesn't
seem to try too hard to recover -- or perhaps, when it does, the new
session goes just as wrong).

The socket statistics on the server report 22 rx drops since boot (out
of 11903K) and no errors of any kind: possibly each of these drops
corresponds to the test runs I've been doing, but there can't be more
than one or two drops per test (I must have crashed the client over ten
times trying to get dumps) which if true seems more fragile than I
expect NFS to be :) so they might well just be coincidental.

I simplified my network for this test run, so the link has literally no
hosts on it right now other than the NFS server and client at issue and
a 10GbE Netgear GS110EMX switch, which reports zero errors and no
packets dropped since it was rebooted months ago. Both ends are the same
Intel X540-AT2 driven by ixgbe. The network cabling has never given me
the least cause for concern, and I've never seen things getting hit by
RSTs when talking to this host before. I've certainly never seen *NFS*
getting a RST. It happens consistently, anyway, which argues strongly
against the cabling :)

Neither client nor server are using any sort of iptables (it's not even
compiled in), and while the server is doing a bit of policy-based
routing and running a couple of bridges for VMs it's not doing anything
that should cause this (and this was replicated when the bridges had
nothing on them other than the host in any case). Syncookies are
compiled out on both hosts (they're still on on the firewall, but that's
not participating in this and isn't even on the same subnet).

Just in case: complete network-related sysctls changed from default on
the client:

net.ipv6.conf.default.keep_addr_on_down = 1

and on the server:

net.ipv4.ip_forward = 1
net.ipv6.conf.all.forwarding = 1
net.ipv6.conf.default.keep_addr_on_down = 1
net.ipv4.ping_group_range = 73 73
net.core.bpf_jit_enable = 1

None of these seem too likely to cause *this*. I wonder how I could
track down where this mess is coming from...
