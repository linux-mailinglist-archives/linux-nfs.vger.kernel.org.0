Return-Path: <linux-nfs+bounces-23320-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B3pZBZCxVmrrAAEAu9opvQ
	(envelope-from <linux-nfs+bounces-23320-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jul 2026 00:00:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AE5759188
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jul 2026 00:00:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=KHBq0p+X;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23320-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23320-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1FEA3020A55
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jul 2026 22:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431A033F361;
	Tue, 14 Jul 2026 22:00:45 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C9342BC3F
	for <linux-nfs@vger.kernel.org>; Tue, 14 Jul 2026 22:00:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784066445; cv=none; b=mmRu3tBk/hj/h1V7KUo31xIzWID6DAOvn8UYr+++7JCfq7SjLZgtJsmBGJH6RM8rTKLNcy8IjCsd8dQGje1GzcThimg1dqJ0HG6zc5wS+3U2XJmQCBTmUz0kmmRi3caBJs5GHn+QKYmL1UpjzLLaKx6zWSCJQDhX4CLJTFGIg9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784066445; c=relaxed/simple;
	bh=CfVJs28W5hxFw8ISq4Xyaqt87hZXNKUuonnOsEGAs38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLVGUXSd1Yk4qKRcYAnSJV38FSibAueZu41Q1ba9zf1s6jAkI5kmdJBWPKFC+t2YxnDn0GhqnMxRpp7eREDNzwOQxvD0/CVeOrqJkcSbeZqLLDY3gc3wVyttiZz/HYv4x2qIbUmATYqmXaTWbJs5pTrTgKCU3Kysc9Q0oyBucXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KHBq0p+X; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784066442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tLV0uO8G+CcD7BsepUgECb6bFenLBgGo57rW9dKc/SY=;
	b=KHBq0p+X5MsyQf3QnHHqAubWNXs5Um0r5uVSth/JK4Zd+kgeuiQ5J40z9twQdL0C7aTxhC
	CQ4jbMVwMnZOuX6wvTLpNM564s/rr0faagVyHpdAtq2xlbwYtJ/Dgr4HP/j9bKjie39pv2
	OH0xH1lf4RZs8jkyEwKzYhFsoMA+UZ0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-a-wLa56ZP72HISr4gaZkUw-1; Tue,
 14 Jul 2026 18:00:40 -0400
X-MC-Unique: a-wLa56ZP72HISr4gaZkUw-1
X-Mimecast-MFC-AGG-ID: a-wLa56ZP72HISr4gaZkUw_1784066438
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B63C61956052;
	Tue, 14 Jul 2026 22:00:38 +0000 (UTC)
Received: from smayhew-thinkpadp1gen4i.remote.csb (unknown [10.22.80.112])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2F5CB30003B8;
	Tue, 14 Jul 2026 22:00:38 +0000 (UTC)
Received: by smayhew-thinkpadp1gen4i.remote.csb (Postfix, from userid 13752)
	id 7075D4E1E582; Tue, 14 Jul 2026 18:00:37 -0400 (EDT)
Date: Tue, 14 Jul 2026 18:00:37 -0400
From: Scott Mayhew <smayhew@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-nfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
	jlayton@kernel.org, chuck.lever@oracle.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Achilles Gaikwad <achillesgaikwad@gmail.com>,
	Trond Myklebust <trondmy@kernel.org>,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v2] NFSv4.2: fix nfs4_listxattr size accounting
Message-ID: <alaxhbWbFMZyC8VQ@smayhew-thinkpadp1gen4i.remote.csb>
References: <CAHC9VhSWWhMjs282cOTT45gn0pa8bDSxD0H24_is7k4tXmGJxQ@mail.gmail.com>
 <ac4f209c-f465-4938-adae-ecd00ecab175@app.fastmail.com>
 <CAHC9VhQYjj3--K6KkDJBf6LfXqtj4TPh5LsMBpPYc0-Zz6wTMA@mail.gmail.com>
 <CAEjxPJ7dttPDxQDa_xXFd1H-QT_vkUwjtnH+=3cmG5dhSiaAXw@mail.gmail.com>
 <CAHC9VhSyCuiPBRWz_vUbx7+L5yLiXkjKX+7UyCLr82-_gAj2NQ@mail.gmail.com>
 <CAEjxPJ4+wgUDY3YxajZ=2D3WLzgat_Mqvr05VtJ4KrXW7_kuXA@mail.gmail.com>
 <CAHC9VhSxpAx+G35fbcMjJ1PfqJxDZYpTEu=qpO+0PQe=nkX5-g@mail.gmail.com>
 <CAHC9VhRq+Vth-4D4OHFAY_6hXqmj=MgTc_2G=3Ehr6bAQzp26Q@mail.gmail.com>
 <CAHC9VhQy4LOgQg0mk+s5sjHOzMe1sxPUgJ2W7vRT8ms4znZp+Q@mail.gmail.com>
 <CAHC9VhR+pWFnt=1pBJTky78br7NsfVcZE=V4UkfkfTbMvBo+mQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAHC9VhR+pWFnt=1pBJTky78br7NsfVcZE=V4UkfkfTbMvBo+mQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,oracle.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-23320-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oracle.com:email,smayhew-thinkpadp1gen4i.remote.csb:mid];
	FORGED_SENDER(0.00)[smayhew@redhat.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:paul@paul-moore.com,m:linux-nfs@vger.kernel.org,m:anna@kernel.org,m:jlayton@kernel.org,m:chuck.lever@oracle.com,m:stephen.smalley.work@gmail.com,m:achillesgaikwad@gmail.com,m:trondmy@kernel.org,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:stephensmalleywork@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smayhew@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 52AE5759188

On Tue, 14 Jul 2026, Paul Moore wrote:

> On Fri, Jul 10, 2026 at 6:20=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > ... and scratch that, the offending commit was that one.
> >
> >    commit 01c2305795a3b6b164df48e72b12022a68fd60c1
> >    Author: Jeff Layton <jlayton@kernel.org>
> >    Date:   Wed Mar 25 10:40:32 2026 -0400
> >
> >    nfsd: add netlink upcall for the nfsd.fh cache
> >
> >    Add netlink-based cache upcall support for the expkey (nfsd.fh) cach=
e,
> >    following the same pattern as the existing svc_export netlink suppor=
t.
> >
> >    Add expkey to the cache-type enum, a new expkey attribute-set with
> >    client, fsidtype, fsid, negative, expiry, and path fields, and the
> >    expkey-get-reqs / expkey-set-reqs operations to the nfsd YAML spec
> >    and generated headers.
> >
> >    Implement nfsd_nl_expkey_get_reqs_dumpit() which snapshots pending
> >    expkey cache requests and sends each entry's seqno, client name,
> >    fsidtype, and fsid over netlink.
> >
> >    Implement nfsd_nl_expkey_set_reqs_doit() which parses expkey cache
> >    responses from userspace (client, fsidtype, fsid, expiry, and path
> >    or negative flag) and updates the cache via svc_expkey_lookup() /
> >    svc_expkey_update().
> >
> >    Wire up the expkey_notify() callback in svc_expkey_cache_template
> >    so cache misses trigger NFSD_CMD_CACHE_NOTIFY multicast events with
> >    NFSD_CACHE_TYPE_EXPKEY.
> >
> >    Signed-off-by: Jeff Layton <jlayton@kernel.org>
> >    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>=20
> Playing around with it some this morning on a current Fedora Rawhide
> system, I can reproduce the problem with a simple command line:
>=20
>  %  mount -t nfs localhost:/mnt/test /mnt/nfs_test
>  mount.nfs: Connection refused for localhost:/mnt/test on /mnt/nfs_test
>=20
> ... adding an explicit "vers=3D{4,4.1,4.2}" has no effect; versions 2
> and 3 are no supported on my kernel builds.  There is nothing obvious
> in dmesg.  I've run with SELinux both in permissive mode and disabled
> and encountered the same problem.  This doesn't appear to be related
> to SELinux, it may simply be that we are the first ones to hit this.
>=20
> As there was some earlier discussion about this being a wonky
> interaction with userspace, here are some of the relevant packages on
> my system:
>=20
> nfs-common-utils-2.9.1-4.rc4.fc45.x86_64
> nfs-client-utils-2.9.1-4.rc4.fc45.x86_64
> nfsv4-client-utils-2.9.1-4.rc4.fc45.x86_64
> nfs-utils-2.9.1-4.rc4.fc45.x86_64
>=20
> My next step is to try disabling portions of the NFS file handle cache
> upcall to see if that is the issue, but it would be nice if the NFS
> devs could take a look at this too.  I'm happy to test things out or
> answer any questions about my test system.

Pardon the dumb question, but are you positive your NFS server is
running?  No errors from 'systemctl status nfs-server.service' or
'systemctl status nfs-mountd.service'?  A connection refused error
typically indicates the server isn't running.

What if you add 'no-netlink=3D1' to the mountd stanza in /etc/nfs.conf and
restart nfs-server.service?

FWIW the netlink upcall requires CAP_NET_ADMIN, which is blocked by the
current selinux-policy on rawhide (and I think it's a dontaudit rule)...
but you said you've disabled SELinux and reproduced your problem, so I'm
scratching my head.  Plus the symptom I ran into was the mount command
hanging, not a 'connection refused' error.  At any rate I filed
https://github.com/fedora-selinux/selinux-policy/pull/3278 to update the
selinux-policy (no movement on that yet) and the most recent mountd
patch improves the fallback to the old proc interface, but I don't think
it's been added to Fedora yet either.

-Scott

>=20
> --=20
> paul-moore.com
>=20


