Return-Path: <linux-nfs+bounces-9222-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D629A1243B
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 13:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F17F1617D2
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 12:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62AB2459A1;
	Wed, 15 Jan 2025 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WmHHOVJt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01EA2459A5
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736945822; cv=none; b=FFHnkm4bU6zI81FTbYhKitKMnVFLrFyStk4ARrhympdDdHABuJOV6lQr+skmOZwaN7G/PmSJDLFuWVsigE1tEMuEWBAYeJuVo2yb74QsbgIy48bVouCZY64fcI6WRKX5MCan+YJgC+3cAwP+ZKNat8LNnCjjqHB9fzy+NoVL7A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736945822; c=relaxed/simple;
	bh=ogMRhHklZu5njqvv41fIjaQQC5VulmBA/4Z1K/xswyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3rBGUk2cTAJ5CMrFaODz5k0XyTSfRTKqsbjxln6HEC5IkoEUTGI/DHwaCVY/inu0Y36sfLr/5oJVe7BOQ7eS134DSCyrzC/e6/6WgSKyTZH7OK2Tk0GdKlCsIxXtymuym6LXNumQnfVCdkObngzVs3SM3scSQ1AP/rYMtIRxkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WmHHOVJt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736945819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FrzQMtPMz9Pj+dJiW37Isp/tNO31wOWf8a72HBMi804=;
	b=WmHHOVJt1jaGIJCPIdf+hH3MK3XJmKoDQipnCm5VxeYvj52Qlign9UpSq+cCesMSR1tzZ9
	zKkNLzx0B8enSVn3GZNf/R5iZlBBYbEmVHZQRLkSVveJMH3l96KzbmD3SFa/crDlbKajQ8
	U2Gd13XWsfi+Vmh2JJG1xWUF2TS6uKU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-AxgMxMtNPt-CeUdBjKJc1Q-1; Wed,
 15 Jan 2025 07:56:58 -0500
X-MC-Unique: AxgMxMtNPt-CeUdBjKJc1Q-1
X-Mimecast-MFC-AGG-ID: AxgMxMtNPt-CeUdBjKJc1Q
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E78B19560AA
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 12:56:57 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.64.152])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 20644195608A;
	Wed, 15 Jan 2025 12:56:57 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 94D513129B2; Wed, 15 Jan 2025 07:56:55 -0500 (EST)
Date: Wed, 15 Jan 2025 07:56:55 -0500
From: Scott Mayhew <smayhew@redhat.com>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [nfs-utils PATCH] nfsdctl: tweak the version subcommand behavior
Message-ID: <Z4ewl7SWj_O0LNtR@aion>
References: <20250108225439.814872-1-smayhew@redhat.com>
 <62c6a307-e17a-4c1a-a66f-1068bd4c2daf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62c6a307-e17a-4c1a-a66f-1068bd4c2daf@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Wed, 15 Jan 2025, Steve Dickson wrote:

> 
> 
> On 1/8/25 5:54 PM, Scott Mayhew wrote:
> > The section for the 'nfsdctl version' subcommand on the man page states
> > that the minorversion is optional, and if omitted it will cause all
> > minorversions to be enabled/disabled, but it currently doesn't work that
> > way.
> > 
> > Make it work that way, with one exception.  If v4.0 is disabled, then
> > 'nfsdctl version +4' will not re-enable it; instead it must be
> > explicitly re-enabled via 'nfsdctl version +4.0'.  This mirrors the way
> > /proc/fs/nfsd/versions works.
> > 
> > Link: https://issues.redhat.com/browse/RHEL-72477
> > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > ---
> >   utils/nfsdctl/nfsdctl.8    |  9 ++++--
> >   utils/nfsdctl/nfsdctl.adoc |  5 +++-
> >   utils/nfsdctl/nfsdctl.c    | 58 +++++++++++++++++++++++++++++++++++---
> >   3 files changed, 64 insertions(+), 8 deletions(-)
> > 
> > diff --git a/utils/nfsdctl/nfsdctl.8 b/utils/nfsdctl/nfsdctl.8
> > index b08fe803..835d60b4 100644
> > --- a/utils/nfsdctl/nfsdctl.8
> > +++ b/utils/nfsdctl/nfsdctl.8
> > @@ -2,12 +2,12 @@
> >   .\"     Title: nfsdctl
> >   .\"    Author: Jeff Layton
> >   .\" Generator: Asciidoctor 2.0.20
> > -.\"      Date: 2024-12-30
> > +.\"      Date: 2025-01-08
> >   .\"    Manual: \ \&
> >   .\"    Source: \ \&
> >   .\"  Language: English
> >   .\"
> > -.TH "NFSDCTL" "8" "2024-12-30" "\ \&" "\ \&"
> > +.TH "NFSDCTL" "8" "2025-01-08" "\ \&" "\ \&"
> >   .ie \n(.g .ds Aq \(aq
> >   .el       .ds Aq '
> >   .ss \n[.ss] 0
> > @@ -172,7 +172,10 @@ MINOR: the minor version integer value
> >   .nf
> >   .fam C
> >   The minorversion field is optional. If not given, it will disable or enable
> > -all minorversions for that major version.
> > +all minorversions for that major version.  Note however that if NFSv4.0 was
> > +previously disabled, it can only be re\-enabled by explicitly specifying the
> > +minorversion (this mirrors the behavior of the /proc/fs/nfsd/versions
> > +interface).
> >   .fam
> >   .fi
> >   .if n .RE
> > diff --git a/utils/nfsdctl/nfsdctl.adoc b/utils/nfsdctl/nfsdctl.adoc
> > index c5921458..20e9bf8e 100644
> > --- a/utils/nfsdctl/nfsdctl.adoc
> > +++ b/utils/nfsdctl/nfsdctl.adoc
> > @@ -91,7 +91,10 @@ Each subcommand can also accept its own set of options and arguments. The
> >       MINOR: the minor version integer value
> >     The minorversion field is optional. If not given, it will disable or enable
> > -  all minorversions for that major version.
> > +  all minorversions for that major version.  Note however that if NFSv4.0 was
> > +  previously disabled, it can only be re-enabled by explicitly specifying the
> > +  minorversion (this mirrors the behavior of the /proc/fs/nfsd/versions
> > +  interface).
> >     Note that versions can only be set when there are no nfsd threads running.
> > diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
> > index 722bf4a0..d86ff80e 100644
> > --- a/utils/nfsdctl/nfsdctl.c
> > +++ b/utils/nfsdctl/nfsdctl.c
> > @@ -761,6 +761,32 @@ static int update_nfsd_version(int major, int minor, bool enabled)
> >   	return -EINVAL;
> >   }
> > +static bool v40_is_disabled(void)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < MAX_NFS_VERSIONS; ++i) {
> > +		if (nfsd_versions[i].major == 0)
> > +			break;
> > +		if (nfsd_versions[i].major == 4 && nfsd_versions[i].minor == 0)
> > +			return !nfsd_versions[i].enabled;
> > +	}
> > +	return false;
> > +}
> > +
> > +static int get_max_minorversion(void)
> > +{
> > +	int i, max = 0;
> > +
> > +	for (i = 0; i < MAX_NFS_VERSIONS; ++i) {
> > +		if (nfsd_versions[i].major == 0)
> > +			break;
> > +		if (nfsd_versions[i].major == 4 && nfsd_versions[i].minor > max)
> > +			max = nfsd_versions[i].minor;
> > +	}
> > +	return max;
> > +}
> > +
> >   static void version_usage(void)
> >   {
> >   	printf("Usage: %s version { {+,-}major.minor } ...\n", taskname);
> > @@ -778,7 +804,8 @@ static void version_usage(void)
> >   static int version_func(struct nl_sock *sock, int argc, char ** argv)
> >   {
> > -	int ret, i;
> > +	int ret, i, j, max_minor;
> > +	bool v40_disabled;
> >   	/* help is only valid as first argument after command */
> >   	if (argc > 1 &&
> > @@ -792,6 +819,9 @@ static int version_func(struct nl_sock *sock, int argc, char ** argv)
> >   		return ret;
> >   	if (argc > 1) {
> > +		v40_disabled = v40_is_disabled();
> > +		max_minor = get_max_minorversion();
> > +
> >   		for (i = 1; i < argc; ++i) {
> >   			int ret, major, minor = 0;
> >   			char sign = '\0', *str = argv[i];
> > @@ -815,9 +845,29 @@ static int version_func(struct nl_sock *sock, int argc, char ** argv)
> >   				return -EINVAL;
> >   			}
> > -			ret = update_nfsd_version(major, minor, enabled);
> > -			if (ret)
> > -				return ret;
> > +			/*
> > +			 * The minorversion field is optional. If omitted, it should
> > +			 * cause all the minor versions for that major version to be
> > +			 * enabled/disabled.
> > +			 *
> > +			 * HOWEVER, we do not enable v4.0 in this manner if it was
> > +			 * previously disabled - it has to be explicitly enabled
> > +			 * instead.  This is to retain the behavior of the old
> > +			 * /proc/fs/nfsd/versions interface.
> > +			 */
> > +			if (major == 4 && ret == 2) {
> > +				for (j = 0; j <= max_minor; ++j) {
> > +					if (j == 0 && enabled && v40_disabled)
> > +						continue;
> > +					ret = update_nfsd_version(major, j, enabled);
> > +					if (ret)
> > +						return ret;
> > +				}
> > +			} else {
> > +				ret = update_nfsd_version(major, minor, enabled);
> > +				if (ret)
> > +					return ret;
> > +			}
> >   		}
> >   		return set_nfsd_versions(sock);
> >   	}
> So nfsdctl version -4 turns of all v4 versions
> and nfsdctl version +4 only turns on +4.1 +4.2.
> nfsdctl version +4.0 is needed to turn on 4.0
> leaving the rest of the minor versions on
> 
> Is this intended?

No.  Jeff and I decided not to retain that behavior.  You should be
looking at the v3 patchset at this point.

-Scott
> 
> steved.
> 


