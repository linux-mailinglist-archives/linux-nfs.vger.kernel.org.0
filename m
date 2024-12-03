Return-Path: <linux-nfs+bounces-8322-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2C99E1DFB
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 14:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22212B46D92
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 12:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A03F1F4260;
	Tue,  3 Dec 2024 12:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DBWURnQg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAE11EE037
	for <linux-nfs@vger.kernel.org>; Tue,  3 Dec 2024 12:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733229816; cv=none; b=QGxu0kYCt5r5b4+krRUib6FroWjIh8yyIwSbIjwR1pqxR8qhxm6MkHz2Hbk5r6ji8MU861NiGsT59izSPonhD3tWBQQbn1Bqd9px2nZKUceAMMb6HBsOWf5SrfyKghjmfzRkb19ctUWPTL8xAGD58R5oSUShaW27O5WohC+aPqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733229816; c=relaxed/simple;
	bh=LDSjR48LbkQIywsTuAjC3c2jc+2TNNPhsTHOdXA8Bv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIod6ewPsmCUntkCsztsJeGhBw27vs6w5fiEGN9Zez540UxFfKO6IM9SOVqhpUwg3JjFxJlr/7/qzMmg5OBUnCp/r65fhplk2OGrOMjMKlDorrEtzLQE14TlahGGJHInU70Ha9P8DD50KxrS9b6chnK7yYAPZrs/NA7vJ7S2zZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DBWURnQg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733229813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bm7Mt1oG5XA9oCGN0Q6VDbJLPyJFfuXgL78W9tKSWJI=;
	b=DBWURnQgJ5Ttj3oZ7BHYL4vvHe0tht1YFtTEwmo98Wk/UoesrJIQHIfyRLpkbzgi32tXbt
	wHh2zrV7M2WxYtlzieOj8TkxVvK36NtstGnAqiSz7I3LkNQnw7Uc6Rx24sCgAOsrLC9hoG
	E/66OxTo3aXDJZHT03syeD+9dSzeaCo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-VWS51j-MNX2pc--6O53pwQ-1; Tue,
 03 Dec 2024 07:43:32 -0500
X-MC-Unique: VWS51j-MNX2pc--6O53pwQ-1
X-Mimecast-MFC-AGG-ID: VWS51j-MNX2pc--6O53pwQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 631131956088
	for <linux-nfs@vger.kernel.org>; Tue,  3 Dec 2024 12:43:31 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.80.18])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0AB551956052;
	Tue,  3 Dec 2024 12:43:31 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 3C1512245BE; Tue,  3 Dec 2024 07:43:29 -0500 (EST)
Date: Tue, 3 Dec 2024 07:43:29 -0500
From: Scott Mayhew <smayhew@redhat.com>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [nfs-utils PATCH] exports: Fix referrals when
 --enable-junction=no
Message-ID: <Z0788RTTA4bn0WBe@aion>
References: <328fdce3-a66b-4254-a178-389caf75a685@redhat.com>
 <20241202203046.1436990-1-smayhew@redhat.com>
 <6b8990cc-ec29-4e01-acd6-8c7ec6487d99@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b8990cc-ec29-4e01-acd6-8c7ec6487d99@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, 02 Dec 2024, Steve Dickson wrote:

> Hey,
> 
> On 12/2/24 3:30 PM, Scott Mayhew wrote:
> > Commit 15dc0bea ("exportd: Moved cache upcalls routines into
> > libexport.a") caused write_fsloc() to be elided when junction support is
> > disabled.  Get rid of the bogus #ifdef HAVE_JUNCTION_SUPPORT blocks so
> > that referrals work again (the only #ifdef HAVE_JUNCTION_SUPPORT should
> > be around actual junction code).
> Why not just take the enable_junction config variable
> out of configure.ac as well?
> 
> If we want junctions/referrals (which are the same)
> IMHO... on all the time... Lets not be able to
> turn them off at all?
> 
> Point being... if we are going remove 3 of the 4
> HAVE_JUNCTION_SUPPORT ifdefs... let get ride of
> all of them.

Junctions and referrals are _not_ the same.  A junction is one mechanism
that can be used to generate a referral.  The other way to generate a
referral is with an export entry, and that is the method that stopped
working after 15dc0bea.

When you set up a referral via an export entry you use the refer=
export option, and the directory must be a mountpoint so that nfsd will
consult the export cache when the client tries to access the directory.

For example, I set up the following in /etc/exports:

/export *(rw,insecure,no_root_squash)
/export/ref     *(rw,insecure,no_root_squash,refer=/export@192.168.124.66)

After the client tries to access /export/ref, this is what I see when I
dump the export cache without my fix:

[root@rawhide ~]# cat /proc/net/rpc/nfsd.export/content
#path domain(flags)
/       *(ro,insecure,no_root_squash,sync,no_wdelay,no_subtree_check,v4root,fsid=0,sec=1)
/export *(rw,insecure,no_root_squash,sync,wdelay,no_subtree_check,uuid=c4eeda84:ea1a4dcd:a043fdc1:372d7878,sec=1)
/export/ref     *(rw,insecure,no_root_squash,sync,wdelay,no_subtree_check,uuid=c4eeda84:ea1a4dcd:a043fdc1:372d7878,sec=1)

Notice there's no refer= option.  So when the client does a LOOKUP of
/export/ref, the server treats it as a normal directory... it doesn't
return NFS4ERR_MOVED and so the client doesn't know to query
fs_locations.

Here is what the export cache looks like with my fix:

[root@rawhide ~]# cat /proc/net/rpc/nfsd.export/content
#path domain(flags)
/export *(rw,insecure,no_root_squash,sync,wdelay,no_subtree_check,uuid=c4eeda84:ea1a4dcd:a043fdc1:372d7878,sec=1)
/       *(ro,insecure,no_root_squash,sync,no_wdelay,no_subtree_check,v4root,fsid=0,sec=1)
/export/ref     *(rw,insecure,no_root_squash,sync,wdelay,no_subtree_check,refer=/export@192.168.124.66,uuid=c4eeda84:ea1a4dcd:a043fdc1:372d7878,sec=1)

Note the refer= option is present, and the referral works normally.

A junction is basically a fancy directory that has the user/group/other
mode bits set to 0 and the sticky bit turned on.  The original mode bits
are stored in the trusted.junction.mode extended attribute and the
referral information is stored in the trusted.junction.nfs extended
attribute.

Continuing with my previous example, I have this in my /etc/exports

[root@rawhide ~]# cat /etc/exports
/export *(rw,insecure,no_root_squash)
/export/ref     *(rw,insecure,no_root_squash,refer=/export@192.168.124.66)

Let's add a referral using a junction.

[root@rawhide ~]# nfsref add /export/junc 192.168.124.66 /export
Created junction /export/junc

In this case, /export/junc didn't previously exist, so the nfsref tool
created it.  If /export/junc did already exist, then the original mode
would be stored in the trusted.junction.mode and the original contents
of the directory would be hidden from the client (as well as
non-privileged users on the server).

You can look up the referral info using 'nfsref lookup':

[root@rawhide ~]# nfsref lookup /export/junc
192.168.124.66:/export

        NFS port:       2049
        Valid for:      0
        Currency:       -1
        Flags:          varsub(false)
        GenFlags:       writable(false), going(false), split(true)
        TransFlags:     rdma(true)
        Class:          simul(0), handle(0), fileid(0)
        Class:          writever(0), change(0), readdir(0)
        Read:           rank(0), order(0)
        Write:          rank(0), order(0)

Or you can just use getfattr if you want to see the raw xml:

[root@rawhide ~]# getfattr --only-values -d -m trusted.junction.nfs /export/junc
getfattr: Removing leading '/' from absolute path names
<?xml version="1.0" encoding="UTF-8"?>
<junction>
  <savedmode bits="755"/>
  <fileset>
    <location>
      <host name="192.168.124.66"/>
      <path>
        <component>export</component>
      </path>
      <currency>-1</currency>
      <genflags writable="false" going="false" split="true"/>
      <transflags rdma="true"/>
      <class simul="0" handle="0" fileid="0" writever="0" change="0" readdir="0"/>
      <read rank="0" order="0"/>
      <write rank="0" order="0"/>
      <flags varsub="false"/>
      <validfor>0</validfor>
    </location>
  </fileset>
</junction>

Note that since the /export/junc referral is stored in a junction, it
doesn't appear in the export info:

[root@rawhide ~]# exportfs -v
/export         <world>(sync,wdelay,hide,no_subtree_check,sec=sys,rw,insecure,no_root_squash,no_all_squash)
/export/ref     <world>(sync,wdelay,hide,no_subtree_check,refer=/export@192.168.124.66,sec=sys,rw,insecure,no_root_squash,no_all_squash)

From the client's standpoint, both style referrals work the same:

root@aion:~# mount 192.168.124.26:/export /mnt/t
root@aion:~# ls /mnt/t
junc  ref
root@aion:~# ls /mnt/t/ref
file
root@aion:~# cat /mnt/t/ref/file
I am on the referral server.
root@aion:~# grep nfs4 /proc/mounts
192.168.124.26:/export /mnt/t nfs4 rw,relatime,vers=4.2,rsize=524288,wsize=524288,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=192.168.124.1,local_lock=none,addr=192.168.124.26 0 0
192.168.124.66:/export /mnt/t/ref nfs4 rw,relatime,vers=4.2,rsize=262144,wsize=262144,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=192.168.124.1,local_lock=none,addr=192.168.124.66 0 0
root@aion:~# ls /mnt/t/junc
file
root@aion:~# cat /mnt/t/junc/file
I am on the referral server.
root@aion:~# grep nfs4 /proc/mounts
192.168.124.26:/export /mnt/t nfs4 rw,relatime,vers=4.2,rsize=524288,wsize=524288,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=192.168.124.1,local_lock=none,addr=192.168.124.26 0 0
192.168.124.66:/export /mnt/t/ref nfs4 rw,relatime,vers=4.2,rsize=262144,wsize=262144,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=192.168.124.1,local_lock=none,addr=192.168.124.66 0 0
192.168.124.66:/export /mnt/t/junc nfs4 rw,relatime,vers=4.2,rsize=262144,wsize=262144,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=192.168.124.1,local_lock=none,addr=192.168.124.66 0 0


So if you want to get rid of that last #ifdef HAVE_JUNCTION_SUPPORT
then you have 2 options:

a) get rid of junctions entirely, leaving users with only the old
(relatively speaking) method for configuring referrals
b) force all packagers of nfs-utils to pull in the extra dependencies
needed to support junctions, which is the exact opposite of what the
Debian folks are requesting.

Or you can take the patch and we can continue to have both style
referrals.

-Scott
> 
> steved.
> > 
> > Fixes: 15dc0bea ("exportd: Moved cache upcalls routines into libexport.a")
> > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > ---
> >   support/export/cache.c | 7 -------
> >   1 file changed, 7 deletions(-)
> > 
> > diff --git a/support/export/cache.c b/support/export/cache.c
> > index 6c0a44a3..3a8e57cf 100644
> > --- a/support/export/cache.c
> > +++ b/support/export/cache.c
> > @@ -34,10 +34,7 @@
> >   #include "pseudoflavors.h"
> >   #include "xcommon.h"
> >   #include "reexport.h"
> > -
> > -#ifdef HAVE_JUNCTION_SUPPORT
> >   #include "fsloc.h"
> > -#endif
> >   #ifdef USE_BLKID
> >   #include "blkid/blkid.h"
> > @@ -999,7 +996,6 @@ static void nfsd_retry_fh(struct delayed *d)
> >   	*dp = d;
> >   }
> > -#ifdef HAVE_JUNCTION_SUPPORT
> >   static void write_fsloc(char **bp, int *blen, struct exportent *ep)
> >   {
> >   	struct servers *servers;
> > @@ -1022,7 +1018,6 @@ static void write_fsloc(char **bp, int *blen, struct exportent *ep)
> >   	qword_addint(bp, blen, servers->h_referral);
> >   	release_replicas(servers);
> >   }
> > -#endif
> >   static void write_secinfo(char **bp, int *blen, struct exportent *ep, int flag_mask, int extra_flag)
> >   {
> > @@ -1120,9 +1115,7 @@ static int dump_to_cache(int f, char *buf, int blen, char *domain,
> >   		qword_addint(&bp, &blen, exp->e_anongid);
> >   		qword_addint(&bp, &blen, fsidnum);
> > -#ifdef HAVE_JUNCTION_SUPPORT
> >   		write_fsloc(&bp, &blen, exp);
> > -#endif
> >   		write_secinfo(&bp, &blen, exp, flag_mask, do_fsidnum ? NFSEXP_FSID : 0);
> >   		if (exp->e_uuid == NULL || different_fs) {
> >   			char u[16];
> 


