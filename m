Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130271F84DE
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jun 2020 21:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgFMTUP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 13 Jun 2020 15:20:15 -0400
Received: from mailhost.m5p.com ([74.104.188.4]:38634 "EHLO mailhost.m5p.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbgFMTUO (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 13 Jun 2020 15:20:14 -0400
X-Greylist: delayed 2068 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Jun 2020 15:20:14 EDT
Received: from m5p.com (mailhost.m5p.com [IPv6:2001:470:1f07:15ff:0:0:0:f7])
        by mailhost.m5p.com (8.15.2/8.15.2) with ESMTPS id 05DIjSN2055236
        (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sat, 13 Jun 2020 14:45:34 -0400 (EDT)
        (envelope-from ehem@m5p.com)
Received: (from ehem@localhost)
        by m5p.com (8.15.2/8.15.2/Submit) id 05DIjRDs055235;
        Sat, 13 Jun 2020 11:45:27 -0700 (PDT)
        (envelope-from ehem)
Date:   Sat, 13 Jun 2020 11:45:27 -0700
From:   Elliott Mitchell <ehem+debian@m5p.com>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     962254@bugs.debian.org, linux-nfs@vger.kernel.org,
        bfields@redhat.com, agruenba@redhat.com
Subject: Re: Umask ignored when mounting NFSv4.2 share of an exported ZFS
 (with acltype=off) (was: Re: Bug#962254: NFS(v4) broken at 4.19.118-2)
Message-ID: <20200613184527.GA54221@mattapan.m5p.com>
References: <20200605051607.GA34405@mattapan.m5p.com>
 <20200605064426.GA1538868@eldamar.local>
 <20200605051607.GA34405@mattapan.m5p.com>
 <20200605174349.GA40135@mattapan.m5p.com>
 <20200605183631.GA1720057@eldamar.local>
 <20200611223711.GA37917@mattapan.m5p.com>
 <20200613125431.GA349352@eldamar.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200613125431.GA349352@eldamar.local>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Spam-Status: No, score=0.4 required=10.0 tests=KHOP_HELO_FCRDNS autolearn=no
        autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mattapan.m5p.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Jun 13, 2020 at 02:54:31PM +0200, Salvatore Bonaccorso wrote:
> indicated this was specifically observed on ZFS on Linux only. Seth
> Arnold's answer seem to be inline with that that the issue is more on
> the ZFS on Linux side and the issue keeps biting people a bit
> unexpectedly. Why does this break with ACL off settings?

I disagree with this assessment.  All of the reporters have been using
ZFS, but this could indicate an absence of testers using other
filesystems.  We need someone with a NFS server which has a 4.15+ kernel
and uses a different filesystem which supports ACLs.

I'm though doubtful ACLs are related to the actual problem.  My
impression of what I've read is they're a useful tool to work around the
problem, but not related to the actual cause.


> But there was at least one other (but again without further
> detail/followups) that it was observed on an export from OpenWRT, but
> no specific details here:
> 
> https://bugs.openwrt.org/index.php?do=details&task_id=2581

This appears to be the same reporter as the RedHat bug report (comment 3
on the RedHat report).  This is a report for the server portion of the
reporter's setup.

Analyzing the setup, I disagree with one of the prior assessment of this
report.  This is OpenWRT on x86_64 hardware which would suggest a
high-end router or embedded device.  Such might well have ECC memory and
a processor fast enough to handle ZFS.



Let me add one more data point.  I had been thinking I might need the
additional features in Linux-ZFS 0.7.12.  As such my NFS server had been
running a 4.9 kernel with Debian's ZFS 0.7.12-2+debg10u1~bpo9+1 packages.
Now with the problem manifesting my NFS server is running a 4.19 kernel
with Debian's ZFS 0.7.12-2+deb10u2 packages.

I could well believe the actual root cause is a problem with the
Linux-ZFS implementation.  What manifested the problem though seems to be
in Linux's NFS implementation between 4.9 and 4.15.  ie Linux-ZFS
implemented /something/ which worked when implemented, but may not have
properly implemented the intended API and was broken by Linux-NFS.


-- 
(\___(\___(\______          --=> 8-) EHM <=--          ______/)___/)___/)
 \BS (    |         ehem+sigmsg@m5p.com  PGP 87145445         |    )   /
  \_CS\   |  _____  -O #include <stddisclaimer.h> O-   _____  |   /  _/
8A19\___\_|_/58D2 7E3D DDF4 7BA6 <-PGP-> 41D1 B375 37D0 8714\_|_/___/5445


