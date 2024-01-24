Return-Path: <linux-nfs+bounces-1322-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1538683B580
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 00:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C3A284E2D
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jan 2024 23:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDE9136644;
	Wed, 24 Jan 2024 23:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="m1Fw7EGQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80A213541D
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jan 2024 23:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706138295; cv=none; b=sn+ryn4kXJMf8gjtM4CMrflWH5pkMScCpLEr3aF3hAuEhsRMxceAwCP4o1QT7hZG8znpOYLDvVw4LlIC7rPGEY4koa9Su3COLeFsAp26mBXXvDU7bmTJb+xcgZOkLC46ukvYbdryKLQ3THEtvNNUesHjJJ34X3ntzkUHhCtMCYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706138295; c=relaxed/simple;
	bh=mPldO+5ucAqTTRmsYZRqhf44qJkYzT8mHvW0iKPXthE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ph9JwCipn3rYNEwJ1GD3q5uFswMU0ujHlfkVPHdUIakoCdlYTo2ndViHwtMH+3U+L1ryBOj3oPY7YoX5WCd+3ZOgMNPV0yLexfal4GAt1fdm6oTP9+78wbY6JoNhg1uTPSLWLl7vVOKgd/qjeTKTES4O3N2TN9p7Fze4MN/8dqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=m1Fw7EGQ; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5ffcb478512so1904497b3.0
        for <linux-nfs@vger.kernel.org>; Wed, 24 Jan 2024 15:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706138292; x=1706743092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V6P2kBwpLhvuazhPy2gjHzB2RbBcBXBsjybb5IDmiB4=;
        b=m1Fw7EGQoKPXr8WEkZDZMbAsZ35GFxqZjdenwQE8lR3AKz6wsejzFNhfduxmBg8NQ+
         lQ+M/+y2jvUAb8MYbUMaKJZBlu3EQfreAkvxULI7gwQs8hAVYJNwr/6FAz7O03+LAbdE
         L6ix8WgJERsts+kCABNGOnJXiCFkcw7HUNZca4l3ozlnNSrPgd6l7yuB0XziJXinQtOx
         nVcbW1O2jEqmm5QqB9CpHjU1rXBUs2rcpKxH91xAREhrbRqkCMWV5VvpwqozjYfATUJv
         W+GXEl8LwB+VpcPuujxGZBPcAi9gI3lbxNDEH4tHWXdsvKDlUdIa/UbOTARdVFugr26b
         ZZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706138292; x=1706743092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6P2kBwpLhvuazhPy2gjHzB2RbBcBXBsjybb5IDmiB4=;
        b=xH9B87Ks2rqq08DmiCPoPHQlUTkNlnd0eB2ppp/Rc2Om0wetcl3RxGShadt+l0SkDa
         fjPSOJ2PLjwA2+c6vVdCi4JCI/DRp7jIr5cO5WJqyihJSznx/04IFnTtOrxBYSRstlOI
         a2M2SliqZpztecnsgFN3x8dokfgHJnLvm/HDxqaRSq3jzkC4PtWM76Ek60yCOaZrOqsp
         981Mn9E5IfSQkAfAOYBknLnepFYP7PEvvgHtf2YAiEjEK+eKQOdDCyVCHt0vHeRmmCV1
         cz9KqM2l8QYW9nfEtxyJLa0w5rP9Vy/rVRxudyoF+yoCdz3L6+02xKd58QQ0dx6T9i0Q
         RlEw==
X-Gm-Message-State: AOJu0YwNEaOp+t2rwqao4kNgKIlBx8Xjv77FPmnQ8mx8gGSVjRHrUKID
	p6zJaV5859/OZVCssA9eOQ8K/BmUALqTn5wuYh2Mu9qlFSZXFurclQGYeGPMJRk=
X-Google-Smtp-Source: AGHT+IHubV9r8ds99U/PiQ6BuYyl67Vp3OzZ8r5LbFvhDZ7Rc8tZSp0sTH3vYLE84qpxRWcCArkCtQ==
X-Received: by 2002:a05:690c:c17:b0:5e7:6557:60e with SMTP id cl23-20020a05690c0c1700b005e76557060emr264613ywb.51.1706138292585;
        Wed, 24 Jan 2024 15:18:12 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id fl13-20020a05690c338d00b005ff8c88bea0sm257328ywb.14.2024.01.24.15.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 15:18:12 -0800 (PST)
Date: Wed, 24 Jan 2024 18:18:11 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH 2/2] nfsd: expose /proc/net/sunrpc/nfsd in net namespaces
Message-ID: <20240124231811.GA1287448@perftesting>
References: <cover.1706124811.git.josef@toxicpanda.com>
 <71058c29683d44644aba8ab295fa028ee41365a8.1706124811.git.josef@toxicpanda.com>
 <ZbFzxmV6zgi/TACb@tissot.1015granger.net>
 <20240124221258.GA1243606@perftesting>
 <e724a63a63f30f927f1780ad9018811bc45bf4e1.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e724a63a63f30f927f1780ad9018811bc45bf4e1.camel@kernel.org>

On Wed, Jan 24, 2024 at 05:57:06PM -0500, Jeff Layton wrote:
> On Wed, 2024-01-24 at 17:12 -0500, Josef Bacik wrote:
> > On Wed, Jan 24, 2024 at 03:32:06PM -0500, Chuck Lever wrote:
> > > On Wed, Jan 24, 2024 at 02:37:00PM -0500, Josef Bacik wrote:
> > > > We are running nfsd servers inside of containers with their own network
> > > > namespace, and we want to monitor these services using the stats found
> > > > in /proc.  However these are not exposed in the proc inside of the
> > > > container, so we have to bind mount the host /proc into our containers
> > > > to get at this information.
> > > > 
> > > > Separate out the stat counters init and the proc registration, and move
> > > > the proc registration into the pernet operations entry and exit points
> > > > so that these stats can be exposed inside of network namespaces.
> > > 
> > > Maybe I missed something, but this looks like it exposes the global
> > > stat counters to all net namespaces...? Is that an information leak?
> > > As an administrator I might be surprised by that behavior.
> > > 
> > > Seems like this patch needs to make nfsdstats and nfsd_svcstats into
> > > per-namespace objects as well.
> > > 
> > > 
> > 
> > I've got the patches written for this, but I've got a question.  There's a 
> > 
> > svc_seq_show(seq, &nfsd_svcstats);
> > 
> > in nfsd/stats.c.  This appears to be an empty struct, there's nothing that
> > utilizes it, so this is always going to print 0 right?  There's a svc_info in
> > the nfsd_net, and that stats block appears to get updated properly.  Should I
> > print this out here?  I don't see anywhere we get the rpc stats out of nfsd, am
> > I missing something?  I don't want to rip out stuff that I don't quite
> > understand.  Thanks,
> > 
> > 
> 
> nfsd_svcstats ends up being the sv_stats for the nfsd service. The RPC
> code has some counters in there for counting different sorts of net and
> rpc events (see svc_process_common, and some of the recv and accept
> handlers).  I think nfsstat(8) may fetch that info via the above
> seqfile, so it's definitely not unused (and it should be printing more
> than just a '0').

Ahhh, I missed this bit

struct svc_program              nfsd_program = {
#if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
        .pg_next                = &nfsd_acl_program,
#endif
        .pg_prog                = NFS_PROGRAM,          /* program number */
        .pg_nvers               = NFSD_NRVERS,          /* nr of entries in
nfsd_version */
        .pg_vers                = nfsd_version,         /* version table */
        .pg_name                = "nfsd",               /* program name */
        .pg_class               = "nfsd",               /* authentication class
*/
        .pg_stats               = &nfsd_svcstats,       /* version table */
        .pg_authenticate        = &svc_set_client,      /* export authentication
*/
        .pg_init_request        = nfsd_init_request,
        .pg_rpcbind_set         = nfsd_rpcbind_set,
};

and so nfsd_svcstats definitely is getting used.

> 
> svc_info is a completely different thing: it's a container for the
> svc_serv...so I'm not sure I understand your question?

I was just confused, and still am a little bit.

The counters are easy, I put those into the nfsd_net struct and make everything
mess with those counters and report those from proc.

However the nfsd_svcstats are in this svc_program thing, which appears to need
to be global?  Or do I need to make it per net as well?  Or do I need to do
something completely different to track the rpc stats per network namespace?
Thanks,

Josef

