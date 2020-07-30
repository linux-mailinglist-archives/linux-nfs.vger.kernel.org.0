Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7CE23380A
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jul 2020 19:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgG3R5h (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Jul 2020 13:57:37 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41362 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728489AbgG3R5g (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Jul 2020 13:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596131854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L0mqRH2cLYM7IVdErkar7uThMbIbLJ0jNEOQrYGsMwo=;
        b=CIuOKwYRHhf4qYSRKE9oRuRbqPR+dgNkLnkMysuZB8ZXj9HBS5+OLW/I9XD7U9f1+c0QtZ
        3kgqLF24/hOdhdjiSvD1w62y65rzJO9u0jH2OaINF3w371Mbyk7dvJ36CD9Nal4XqhJifo
        gnXYmoXo1Ol67Sj7LEnA0QitOXJUuME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-QFB9pvWENyiY35-449HmUQ-1; Thu, 30 Jul 2020 13:57:29 -0400
X-MC-Unique: QFB9pvWENyiY35-449HmUQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEAEDE919;
        Thu, 30 Jul 2020 17:57:28 +0000 (UTC)
Received: from ovpn-112-29.phx2.redhat.com (ovpn-112-29.phx2.redhat.com [10.3.112.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C68278A19A;
        Thu, 30 Jul 2020 17:57:27 +0000 (UTC)
Message-ID: <3c25f1dff6bf822aaba36b812bb4773e97df975e.camel@redhat.com>
Subject: Re: Fedora 32 rpc.gssd misbehavior
From:   Simo Sorce <simo@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Robbie Harwood <rharwood@redhat.com>
Date:   Thu, 30 Jul 2020 13:57:26 -0400
In-Reply-To: <5DE48B32-CB63-4753-B7F4-3CAC55A111D8@oracle.com>
References: <83856C49-309A-4AD6-9B27-9F93FDDE00DF@oracle.com>
         <48B9E144-41CA-4DF0-A88D-2F6652A0EBF1@oracle.com>
         <5ae72c7b0afa65d509db23686d72a1055f7cc6b4.camel@redhat.com>
         <5DE48B32-CB63-4753-B7F4-3CAC55A111D8@oracle.com>
Organization: Red Hat, Inc.
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2020-07-30 at 13:09 -0400, Chuck Lever wrote:
> > On Jul 30, 2020, at 12:14 PM, Simo Sorce <simo@redhat.com> wrote:
> > 
> > On Wed, 2020-07-29 at 14:27 -0400, Chuck Lever wrote:
> > > > On Jul 29, 2020, at 1:19 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
> > > > 
> > > > Hi!
> > > > 
> > > > I recently updated my test systems from EL7 to Fedora 32, and
> > > > NFSv4.0 with Kerberos has stopped working.
> > > > 
> > > > I mount with "klimt.ib" as before. The client workload stops
> > > > dead when the server tries to perform its first CB_RECALL.
> > > > 
> > > > I added some client instrumentation:
> > > > 
> > > >  kernel: NFSv4: Callback principal (nfs@klimt.ib.1015granger.net) does not match acceptor (nfs@klimt.ib).
> > > >  kernel: NFS: NFSv4 callback contains invalid cred
> > > > 
> > > > I boosted gssd verbosity, and it says:
> > > > 
> > > >  rpc.gssd[986]: doing downcall: lifetime_rec=72226 acceptor=nfs@klimt.ib
> > > > 
> > > > But it knows the full hostname for the server:
> > > > 
> > > >  rpc.gssd[986]: Full hostname for 'klimt.ib' is 'klimt.ib.1015granger.net'
> > > > 
> > > > 
> > > > The acceptor appears to come from the Kerberos library. Shouldn't
> > > > it be canonicalized? If so, should the Kerberos library do it, or
> > > > should gssd? Since this behavior appeared after an upgrade, I
> > > > suspect a Kerberos library regression. But it could be config-
> > > > related, since both systems were re-imaged from the ground up.
> > > > 
> > > > Also noticing some other problems on the server (missing hostname
> > > > strings in debug messages, sssd_kcm infinite loops, and gssd
> > > > sending garbage to the client after the NULL request that
> > > > establishes the callback context).
> > > > 
> > > > But let's look at the client acceptor problem first.
> > > 
> > > I believe I found the problem.
> > > 
> > > 8bffe8c5ec1a ("gssd: add /etc/nfs.conf support") added a number of gssd config
> > > options to /etc/nfs.conf, including "avoid-dns". The default setting of avoid-
> > > dns is 1. When I set this option on my client system explicitly to 0, NFSv4.0
> > > with Kerberos works again.
> > > 
> > > Is there a reason the default setting is 1?
> > > 
> > 
> > Now that you mention DNS, this may be an interaction between a new
> > default in Fedora 32 and how your environment is setup re DNS.
> > 
> > In F32 we changed the option dns_canonicalize_hostname from 'true' to
> > 'fallback'.
> > This is a transitional state to eventually move it to 'false' at some
> > point in the future.
> > 
> > What it changes in practice is that it will first try the name passed
> > in *as is* and only as a fallback try a CNAME if the name passed is not
> > resolved as an A name. If you have principals in the KDC for both
> > names, but you do not have keys in the keytab for both, you can have
> > transitional issues.
> > 
> > Additionally we discovered a bug that causes non qualified names to
> > fail resolution with the 'fallback' option.
> > If your name in the principal is really not qualified it will try to
> > qualify it anyway, so if your principal is literally nfs/foo@FOO
> > libgssapi may try to use nfs/foo.my.domdain@FOO, where "my.domain" is
> > what is defined in resolv.conf search path.
> > 
> > We are trying to address this regression.
> > 
> > So try to set dns_canonicalize_hostname to true to see if that may
> > influence your issue. If so, please let me know, as we still need to
> > address this where possible.
> 
> I set avoid-dns to 1 and dns_canonicalize_hostname to true. The
> workload hang is not reproducible, and the acceptor is fully qualified.
> 
> rpc.gssd[965]: doing downcall: lifetime_rec=86338 acceptor=nfs@klimt.ib.1015granger.net

Chuck,
can you tell what does klimt.ib.1015granger.net resolve to (A names
CNAMEs, not really interested in IP address)?
Also what ticket do you ultimately get in the ccache when this request
is made ?

Simo.

-- 
Simo Sorce
RHEL Crypto Team
Red Hat, Inc




