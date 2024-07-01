Return-Path: <linux-nfs+bounces-4502-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D4291E9A1
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 22:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F17528258B
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 20:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85A316F850;
	Mon,  1 Jul 2024 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="skuZDf80"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2895516F0FE
	for <linux-nfs@vger.kernel.org>; Mon,  1 Jul 2024 20:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719866008; cv=none; b=pvkTAZFwQZq37jPJhzmSKp8uFH5esVY46ISculLgyd0mIKGSkq+Dhm+aVuitVoXf758ns7XCpWrNYrwBHA6Z6XDyu88c9QIr0bKP82F+pne1GsFTkW04psO4YwkPFxwgZSQXAQPhyg9TMkY7LT+R32KMijfFC7IHQf4XaSOBruM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719866008; c=relaxed/simple;
	bh=jEinBn73kAQeiKA6biJBVZ0znaclnyoeCW0MFqYT2GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIVteFwk01w3lZGyP5Q+OcL7GP0UjXv78OkkAVl0INc22hhMV9oJ66BTfhNkUFJoWo8E3UAxcl7qJvjg6c6NXSr/iW6ndB2cITF91jVEkWucNlc/y0zPXhnsq85RUghHRV5xT+GTSwW6Hp8QujUL+lyBxicx/FqLGvc3svwPGlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=skuZDf80; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-79c076c0d83so210588785a.3
        for <linux-nfs@vger.kernel.org>; Mon, 01 Jul 2024 13:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719866006; x=1720470806; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eJWQ2aw4J/WLIAVkZzcuHyyU5owW6RRYm2ZeVPaEzB8=;
        b=skuZDf80doiLymvCWsYlJ/cKG3vZ2Q9BukFjNM7u/x0SGqbYFJ011iPuV6oDCIO7a6
         HUAoBzRGXal73sktZYyKb0TwR2e7wEfj1mHmDsGvKSDRTZW3SPFWOegfKl/PvbPs3Y6c
         3wz454SIm87ualx41QjvPlxfSxP0yTzyv1CpudOk89UYSjfogovtFCroTYXD6qU7M01s
         qhj3XU41S0ZDH2vWvyMoL9402IdEpdLodXOybK49lcjzyHN5w3aIQNh/uw0nIbNf5CoA
         Lqz9fLshNXhhPAoOMmyrJJXb3fvP2HZOXILUWXKssSlHSvI9qXlkJvGxwrYSr9Rar0iS
         GROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719866006; x=1720470806;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJWQ2aw4J/WLIAVkZzcuHyyU5owW6RRYm2ZeVPaEzB8=;
        b=D3suyoJEUM1nyGBrL3SU0J3iV7kvqBgyVG1p72nmp+ezIG5YN0Yv5dfkFYBCPvcB3K
         8bI12CNmbbAh36vh7bEUhpSvRWGQNQYuir+AqLBYSEoCMsXTzC1gfkS7F+YDwGG8srcG
         wCeRfsqZY3hOI3/SXiwEF9IPkDoyFlwzjrQv3NzhW79DnUyB//lYcJ7+j81OxAud646p
         DnvaOkGmwP1KHgDSE8ug+JvGpdET3a+KyvUTT6li7poZ2t0zKXSkP160HyV/mjvyDnqA
         Qo1APvqt/cOO+Ytju+Et4iDqVOiTHANs+lWDywaIRIZ5EF66gVQF4yWfNEkP1/Tl5JLs
         cr2g==
X-Forwarded-Encrypted: i=1; AJvYcCX3N259a3Z6wq4iXwjEp4h1lUsuX7k+lqmAr+c0mJ+iswctwxYiunl8k/yZswsSDv3Og33Ke2/umF1kLwx3Vnr5TqVRiTMn+Va7
X-Gm-Message-State: AOJu0YzdxnaSSQDZIZx+ISfDQYAfnfW1O4wI8iV9ihr2BsYSPivt1nRD
	sIVzzILhymmNyGT2gmrLO+OEDeHVTyyJg0fuxn7gwL4l6m9Yomhshhi1f0tff8s=
X-Google-Smtp-Source: AGHT+IHquiezZuh7KYAcKV1s9Va0xkaeqQinyvX7/0dTMvr1KCMbQie9WJzy87YdgytxI01W/IdsjQ==
X-Received: by 2002:a05:620a:2683:b0:79c:f0e:f793 with SMTP id af79cd13be357-79d7b99e142mr1064186885a.14.1719866006069;
        Mon, 01 Jul 2024 13:33:26 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d692600b6sm384373985a.20.2024.07.01.13.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 13:33:25 -0700 (PDT)
Date: Mon, 1 Jul 2024 16:33:24 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andi Kleen <ak@linux.intel.com>, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 09/11] btrfs: convert to multigrain timestamps
Message-ID: <20240701203324.GA510298@perftesting>
References: <20240701-mgtime-v2-0-19d412a940d9@kernel.org>
 <20240701-mgtime-v2-9-19d412a940d9@kernel.org>
 <20240701134936.GB504479@perftesting>
 <ec952d79bbe19d80a7aff495e9784c60a1a1e668.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec952d79bbe19d80a7aff495e9784c60a1a1e668.camel@kernel.org>

On Mon, Jul 01, 2024 at 09:57:43AM -0400, Jeff Layton wrote:
> On Mon, 2024-07-01 at 09:49 -0400, Josef Bacik wrote:
> > On Mon, Jul 01, 2024 at 06:26:45AM -0400, Jeff Layton wrote:
> > > Enable multigrain timestamps, which should ensure that there is an
> > > apparent change to the timestamp whenever it has been written after
> > > being actively observed via getattr.
> > > 
> > > Beyond enabling the FS_MGTIME flag, this patch eliminates
> > > update_time_for_write, which goes to great pains to avoid in-memory
> > > stores. Just have it overwrite the timestamps unconditionally.
> > > 
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/btrfs/file.c  | 25 ++++---------------------
> > >  fs/btrfs/super.c |  3 ++-
> > >  2 files changed, 6 insertions(+), 22 deletions(-)
> > > 
> > > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > > index d90138683a0a..409628c0c3cc 100644
> > > --- a/fs/btrfs/file.c
> > > +++ b/fs/btrfs/file.c
> > > @@ -1120,26 +1120,6 @@ void btrfs_check_nocow_unlock(struct
> > > btrfs_inode *inode)
> > >  	btrfs_drew_write_unlock(&inode->root->snapshot_lock);
> > >  }
> > >  
> > > -static void update_time_for_write(struct inode *inode)
> > > -{
> > > -	struct timespec64 now, ts;
> > > -
> > > -	if (IS_NOCMTIME(inode))
> > > -		return;
> > > -
> > > -	now = current_time(inode);
> > > -	ts = inode_get_mtime(inode);
> > > -	if (!timespec64_equal(&ts, &now))
> > > -		inode_set_mtime_to_ts(inode, now);
> > > -
> > > -	ts = inode_get_ctime(inode);
> > > -	if (!timespec64_equal(&ts, &now))
> > > -		inode_set_ctime_to_ts(inode, now);
> > > -
> > > -	if (IS_I_VERSION(inode))
> > > -		inode_inc_iversion(inode);
> > > -}
> > > -
> > >  static int btrfs_write_check(struct kiocb *iocb, struct iov_iter
> > > *from,
> > >  			     size_t count)
> > >  {
> > > @@ -1171,7 +1151,10 @@ static int btrfs_write_check(struct kiocb
> > > *iocb, struct iov_iter *from,
> > >  	 * need to start yet another transaction to update the
> > > inode as we will
> > >  	 * update the inode when we finish writing whatever data
> > > we write.
> > >  	 */
> > > -	update_time_for_write(inode);
> > > +	if (!IS_NOCMTIME(inode)) {
> > > +		inode_set_mtime_to_ts(inode,
> > > inode_set_ctime_current(inode));
> > > +		inode_inc_iversion(inode);
> > 
> > You've dropped the
> > 
> > if (IS_I_VERSION(inode))
> > 
> > check here, and it doesn't appear to be in inode_inc_iversion.  Is
> > there a
> > reason for this?  Thanks,
> > 
> 
> AFAICT, btrfs always sets SB_I_VERSION. Are there any cases where it
> isn't? If so, then I can put this check back. I'll make a note about it
> in the changelog if not.

Ah ok I'm dumb, ignore me, thanks,

Josef

