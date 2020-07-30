Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE462338AD
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jul 2020 21:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbgG3TKU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Jul 2020 15:10:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44302 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730411AbgG3TKT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Jul 2020 15:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596136217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vkS6oOaJxuGfG+P7z1kvWDy8H7gh5AspGeYTp1QkiK4=;
        b=XxrobTIdXaQH2e3EGL6i/C5fixd9bAYGjLlXn+9qc1jD3TrZMaxmtYmhtKOQs2aTpA979I
        9WLNKx76nWoSN4qizkbodRq+hL1CEi909KUrL+8XXJBI/qZLvVLaoIY9CuTiBW0m+Dvv+N
        l9N0w/s6WqDXY0zmXtP0mRa66Fqej5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-XF_ppqYcMhe4uZlrDtsx3g-1; Thu, 30 Jul 2020 15:10:13 -0400
X-MC-Unique: XF_ppqYcMhe4uZlrDtsx3g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC63A1005504;
        Thu, 30 Jul 2020 19:10:12 +0000 (UTC)
Received: from ovpn-112-29.phx2.redhat.com (ovpn-112-29.phx2.redhat.com [10.3.112.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 364BA71931;
        Thu, 30 Jul 2020 19:10:12 +0000 (UTC)
Message-ID: <ee4b7c47bc37a53afd751159ae39d01d7cd3ee34.camel@redhat.com>
Subject: Re: Fedora 32 rpc.gssd misbehavior
From:   Simo Sorce <simo@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Robbie Harwood <rharwood@redhat.com>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Thu, 30 Jul 2020 15:10:11 -0400
In-Reply-To: <4EB4AE01-F6D4-4E8F-86BF-C8BB07E63517@oracle.com>
References: <83856C49-309A-4AD6-9B27-9F93FDDE00DF@oracle.com>
         <48B9E144-41CA-4DF0-A88D-2F6652A0EBF1@oracle.com>
         <5ae72c7b0afa65d509db23686d72a1055f7cc6b4.camel@redhat.com>
         <jlg7dulylq6.fsf@redhat.com>
         <4EB4AE01-F6D4-4E8F-86BF-C8BB07E63517@oracle.com>
Organization: Red Hat, Inc.
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2020-07-30 at 13:59 -0400, Chuck Lever wrote:
> > On Jul 30, 2020, at 1:08 PM, Robbie Harwood <rharwood@redhat.com> wrote:
> > 
> > Simo Sorce <simo@redhat.com> writes:
> > 
> > > On Wed, 2020-07-29 at 14:27 -0400, Chuck Lever wrote:
> > > > > On Jul 29, 2020, at 1:19 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
> > > > > 
> > > > > Hi!
> > > > > 
> > > > > I recently updated my test systems from EL7 to Fedora 32, and
> > > > > NFSv4.0 with Kerberos has stopped working.
> > > > > 
> > > > > I mount with "klimt.ib" as before. The client workload stops
> > > > > dead when the server tries to perform its first CB_RECALL.
> > > > > 
> > > > > I added some client instrumentation:
> > > > > 
> > > > >  kernel: NFSv4: Callback principal (nfs@klimt.ib.1015granger.net) does not match acceptor (nfs@klimt.ib).
> > > > >  kernel: NFS: NFSv4 callback contains invalid cred
> > > > > 
> > > > > I boosted gssd verbosity, and it says:
> > > > > 
> > > > >  rpc.gssd[986]: doing downcall: lifetime_rec=72226 acceptor=nfs@klimt.ib
> > > > > 
> > > > > But it knows the full hostname for the server:
> > > > > 
> > > > >  rpc.gssd[986]: Full hostname for 'klimt.ib' is 'klimt.ib.1015granger.net'
> > > > > 
> > > > > 
> > > > > The acceptor appears to come from the Kerberos library. Shouldn't
> > > > > it be canonicalized? If so, should the Kerberos library do it, or
> > > > > should gssd? Since this behavior appeared after an upgrade, I
> > > > > suspect a Kerberos library regression. But it could be config-
> > > > > related, since both systems were re-imaged from the ground up.
> > > > > 
> > > > > Also noticing some other problems on the server (missing hostname
> > > > > strings in debug messages, sssd_kcm infinite loops, and gssd
> > > > > sending garbage to the client after the NULL request that
> > > > > establishes the callback context).
> > > > > 
> > > > > But let's look at the client acceptor problem first.
> > > > 
> > > > I believe I found the problem.
> > > > 
> > > > 8bffe8c5ec1a ("gssd: add /etc/nfs.conf support") added a number of gssd config
> > > > options to /etc/nfs.conf, including "avoid-dns". The default setting of avoid-
> > > > dns is 1. When I set this option on my client system explicitly to 0, NFSv4.0
> > > > with Kerberos works again.
> > > > 
> > > > Is there a reason the default setting is 1?
> > > > 
> > > 
> > > Now that you mention DNS, this may be an interaction between a new
> > > default in Fedora 32 and how your environment is setup re DNS.
> > > 
> > > In F32 we changed the option dns_canonicalize_hostname from 'true' to
> > > 'fallback'.
> > > This is a transitional state to eventually move it to 'false' at some
> > > point in the future.
> > > 
> > > What it changes in practice is that it will first try the name passed
> > > in *as is* and only as a fallback try a CNAME if the name passed is not
> > > resolved as an A name. If you have principals in the KDC for both
> > > names, but you do not have keys in the keytab for both, you can have
> > > transitional issues.
> > > 
> > > Additionally we discovered a bug that causes non qualified names to
> > > fail resolution with the 'fallback' option.
> > > If your name in the principal is really not qualified it will try to
> > > qualify it anyway, so if your principal is literally nfs/foo@FOO
> > > libgssapi may try to use nfs/foo.my.domdain@FOO, where "my.domain" is
> > > what is defined in resolv.conf search path.
> > > 
> > > We are trying to address this regression.
> > > 
> > > So try to set dns_canonicalize_hostname to true to see if that may
> > > influence your issue. If so, please let me know, as we still need to
> > > address this where possible.
> > 
> > Also, please try setting `qualify_shortname = ""`.  (I did update the
> > config file we ship with Fedora, but upstream's default turns that on.
> > This is a temporary workaround while we merge something better
> > upstream.)
> 
> For completeness, I tried:
> 
> avoid-dns = 1
> dns_canonicalize_hostname = fallback
> qualify_shortname = ""
> 
> which is the default configuration out of the shrink wrap.
> 
> The workload hangs as before, and the acceptor is unqualified:
> 
> rpc.gssd[985]: doing downcall: lifetime_rec=84046 acceptor=nfs@klimt.ib
> 
> 
> The test is:
> 
> Configured domain name is "1015granger.net"
> 
> Fully-qualified client hostname is "manet.ib.granger.net"
> 
> Fully-qualified server hostname is "klimt.ib.granger.net"
> 
> mount command is "mount -o vers=4.0,sec=sys klimt.ib:/export /mnt"
> 
> In this case, both systems have keytabs and service principals, so
> the client automatically attempts to establish a GSS context for
> lease management and callback operations. The failure occurs because
> the server's principal is nfs@klimt.ib.1015granger.net but the
> acceptor now matches the server hostname from the mount command line,
> which is not always fully qualified.

Ok, TBH I personally consider the syntax you  are currently using as
working by accident and that you should really sue the FQDN on the
command line (I assume it works that way, right?), however I understand
this is also technically a regression, that said I do not think we can
really fix this case because your "shortname" is not short (it has a
dot in it) so the heuristicts won't trigger to qualify it even when you
set qualify_shortname="".

I have the feeling we'll break this case, and our answer will have to
be "use the fqdn on the command line".

Simo.
 
-- 
Simo Sorce
RHEL Crypto Team
Red Hat, Inc




