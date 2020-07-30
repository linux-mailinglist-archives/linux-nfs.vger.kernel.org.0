Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A840233853
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jul 2020 20:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgG3SUg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Jul 2020 14:20:36 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56317 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726343AbgG3SUf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Jul 2020 14:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596133233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wPGWDFSIBXopOaYTUDf6YoGPGpC7WJ68YZZX69mT4D4=;
        b=Vlf4vRIxJIeGU+ZrsBU3iwFgewL3r4X/BvsFThIx7+b6ENRk2qBkvPCvclm2H8XoZjAzBE
        klr6grLbGlrN0hIk5yibhMiWO1mnZT92YpSA102o09yS3ZjdPaEpgUJP59hiJwmlbafsyl
        zkS5LxHzkdC7e6NpD5q7iZvSTxeU9Zs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-Q0YK32bUMMCxO8UUqbEjxA-1; Thu, 30 Jul 2020 14:20:18 -0400
X-MC-Unique: Q0YK32bUMMCxO8UUqbEjxA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D83438015CE;
        Thu, 30 Jul 2020 18:20:17 +0000 (UTC)
Received: from ovpn-112-29.phx2.redhat.com (ovpn-112-29.phx2.redhat.com [10.3.112.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A8BA5F7D8;
        Thu, 30 Jul 2020 18:20:17 +0000 (UTC)
Message-ID: <08c0450556bac1a745b567401482efe9ec6a6ac5.camel@redhat.com>
Subject: Re: Fedora 32 rpc.gssd misbehavior
From:   Simo Sorce <simo@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Robbie Harwood <rharwood@redhat.com>
Date:   Thu, 30 Jul 2020 14:20:16 -0400
In-Reply-To: <D39C21E9-791C-40F7-B9D1-DAC69210A437@oracle.com>
References: <83856C49-309A-4AD6-9B27-9F93FDDE00DF@oracle.com>
         <48B9E144-41CA-4DF0-A88D-2F6652A0EBF1@oracle.com>
         <5ae72c7b0afa65d509db23686d72a1055f7cc6b4.camel@redhat.com>
         <5DE48B32-CB63-4753-B7F4-3CAC55A111D8@oracle.com>
         <3c25f1dff6bf822aaba36b812bb4773e97df975e.camel@redhat.com>
         <D39C21E9-791C-40F7-B9D1-DAC69210A437@oracle.com>
Organization: Red Hat, Inc.
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2020-07-30 at 14:07 -0400, Chuck Lever wrote:
> > On Jul 30, 2020, at 1:57 PM, Simo Sorce <simo@redhat.com> wrote:
> > 
> > On Thu, 2020-07-30 at 13:09 -0400, Chuck Lever wrote:
> > > > On Jul 30, 2020, at 12:14 PM, Simo Sorce <simo@redhat.com> wrote:
> > > > 
> > > > On Wed, 2020-07-29 at 14:27 -0400, Chuck Lever wrote:
> > > > > > On Jul 29, 2020, at 1:19 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
> > > > > > 
> > > > > > Hi!
> > > > > > 
> > > > > > I recently updated my test systems from EL7 to Fedora 32, and
> > > > > > NFSv4.0 with Kerberos has stopped working.
> > > > > > 
> > > > > > I mount with "klimt.ib" as before. The client workload stops
> > > > > > dead when the server tries to perform its first CB_RECALL.
> > > > > > 
> > > > > > I added some client instrumentation:
> > > > > > 
> > > > > > kernel: NFSv4: Callback principal (nfs@klimt.ib.1015granger.net) does not match acceptor (nfs@klimt.ib).
> > > > > > kernel: NFS: NFSv4 callback contains invalid cred
> > > > > > 
> > > > > > I boosted gssd verbosity, and it says:
> > > > > > 
> > > > > > rpc.gssd[986]: doing downcall: lifetime_rec=72226 acceptor=nfs@klimt.ib
> > > > > > 
> > > > > > But it knows the full hostname for the server:
> > > > > > 
> > > > > > rpc.gssd[986]: Full hostname for 'klimt.ib' is 'klimt.ib.1015granger.net'
> > > > > > 
> > > > > > 
> > > > > > The acceptor appears to come from the Kerberos library. Shouldn't
> > > > > > it be canonicalized? If so, should the Kerberos library do it, or
> > > > > > should gssd? Since this behavior appeared after an upgrade, I
> > > > > > suspect a Kerberos library regression. But it could be config-
> > > > > > related, since both systems were re-imaged from the ground up.
> > > > > > 
> > > > > > Also noticing some other problems on the server (missing hostname
> > > > > > strings in debug messages, sssd_kcm infinite loops, and gssd
> > > > > > sending garbage to the client after the NULL request that
> > > > > > establishes the callback context).
> > > > > > 
> > > > > > But let's look at the client acceptor problem first.
> > > > > 
> > > > > I believe I found the problem.
> > > > > 
> > > > > 8bffe8c5ec1a ("gssd: add /etc/nfs.conf support") added a number of gssd config
> > > > > options to /etc/nfs.conf, including "avoid-dns". The default setting of avoid-
> > > > > dns is 1. When I set this option on my client system explicitly to 0, NFSv4.0
> > > > > with Kerberos works again.
> > > > > 
> > > > > Is there a reason the default setting is 1?
> > > > > 
> > > > 
> > > > Now that you mention DNS, this may be an interaction between a new
> > > > default in Fedora 32 and how your environment is setup re DNS.
> > > > 
> > > > In F32 we changed the option dns_canonicalize_hostname from 'true' to
> > > > 'fallback'.
> > > > This is a transitional state to eventually move it to 'false' at some
> > > > point in the future.
> > > > 
> > > > What it changes in practice is that it will first try the name passed
> > > > in *as is* and only as a fallback try a CNAME if the name passed is not
> > > > resolved as an A name. If you have principals in the KDC for both
> > > > names, but you do not have keys in the keytab for both, you can have
> > > > transitional issues.
> > > > 
> > > > Additionally we discovered a bug that causes non qualified names to
> > > > fail resolution with the 'fallback' option.
> > > > If your name in the principal is really not qualified it will try to
> > > > qualify it anyway, so if your principal is literally nfs/foo@FOO
> > > > libgssapi may try to use nfs/foo.my.domdain@FOO, where "my.domain" is
> > > > what is defined in resolv.conf search path.
> > > > 
> > > > We are trying to address this regression.
> > > > 
> > > > So try to set dns_canonicalize_hostname to true to see if that may
> > > > influence your issue. If so, please let me know, as we still need to
> > > > address this where possible.
> > > 
> > > I set avoid-dns to 1 and dns_canonicalize_hostname to true. The
> > > workload hang is not reproducible, and the acceptor is fully qualified.
> > > 
> > > rpc.gssd[965]: doing downcall: lifetime_rec=86338 acceptor=nfs@klimt.ib.1015granger.net
> > 
> > Chuck,
> > can you tell what does klimt.ib.1015granger.net resolve to (A names
> > CNAMEs, not really interested in IP address)?
> 
> [root@manet ~]# dig klimt.ib.1015granger.net
> 
> ; <<>> DiG 9.11.20-RedHat-9.11.20-1.fc32 <<>> klimt.ib.1015granger.net
> ;; global options: +cmd
> ;; Got answer:
> ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 55806
> ;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 1, ADDITIONAL: 2
> 
> ;; OPT PSEUDOSECTION:
> ; EDNS: version: 0, flags:; udp: 4096
> ; COOKIE: 0a7a07d8b06eedeab886314f5f230a8c6f752fe4a24c2f97 (good)
> ;; QUESTION SECTION:
> ;klimt.ib.1015granger.net.	IN	A
> 
> ;; ANSWER SECTION:
> klimt.ib.1015granger.net. 10800	IN	A	192.168.2.55
> 
> ;; AUTHORITY SECTION:
> ib.1015granger.net.	10800	IN	NS	gateway.1015granger.net.
> 
> ;; ADDITIONAL SECTION:
> gateway.1015granger.net. 10800	IN	A	192.168.1.1
> 
> ;; Query time: 0 msec
> ;; SERVER: 192.168.1.1#53(192.168.1.1)
> ;; WHEN: Thu Jul 30 13:59:40 EDT 2020
> ;; MSG SIZE  rcvd: 135
> 
> [root@manet ~]#

so klimt is an A name, and it is a fqdn in the principal, so I am
puzled why the krb5.conf option would make a difference, unless
192.168.2.55 perhaps resolves to a different name and you have rdns =
true ?

> 
> > Also what ticket do you ultimately get in the ccache when this request
> > is made ?
> 
> I'm not exactly sure what you're asking, but:
> 
> [root@manet ~]# klist FILE:/tmp/krb5ccmachine_1015GRANGER.NET
> Ticket cache: FILE:/tmp/krb5ccmachine_1015GRANGER.NET
> Default principal: host/manet.1015granger.net@1015GRANGER.NET
> 
> Valid starting       Expires              Service principal
> 07/30/2020 13:45:38  07/31/2020 13:45:38  krbtgt/1015GRANGER.NET@1015GRANGER.NET
> 	renew until 08/06/2020 13:45:38
> [root@manet ~]#

I was asking what ticket you get to use to talk to klimt, this is the
machine ccache but it only has the krbtgt for the machine host key.


And now that I reread the thread better I see:

Callback principal (nfs@klimt.ib.1015granger.net) does not match
acceptor (nfs@klimt.ib)

do you use klimt.ib explicitly somewhere instad of the fqdn and rely on
name expansion ?

Simo.

-- 
Simo Sorce
RHEL Crypto Team
Red Hat, Inc




