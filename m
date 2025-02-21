Return-Path: <linux-nfs+bounces-10252-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662E8A3F645
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 14:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628C316FA5E
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 13:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5829B208962;
	Fri, 21 Feb 2025 13:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yblj9cwn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7995E204590
	for <linux-nfs@vger.kernel.org>; Fri, 21 Feb 2025 13:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740145385; cv=none; b=QltqrypWkPG1BcdUvoNb8rRgNY6iCQqHiiwQqNy81muGxgMw4RoF4EoWAYdzhlQDdM+maYj6zzNjTLCrDqGWMhX1tRjGMgi7H7s4BLe5Uj/l1TksMyDhKrb7VFcykVbUYe/aYzUNhS9ZjsZnEHyxSRODrtbXcjVB5ChopJkXojY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740145385; c=relaxed/simple;
	bh=N7oidlW2cyml89j9E0MxMhjBP3BiXWHe/JW16o0m4uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fhzu3R551Z5d3IEhVFMXdEsQbHOPoNx6oSU7YBo3uyh4BNp04jDnblqonwzLIS8vjGJTN+EpCpI+RtVvTWB1OY6Ou1g9RqCMEDrVXqBA4R/zas2w1d2xkmJr+ZvmansojuEX25uzdAUrz47bJumI6oG/W/7ODrMpicIAgF7HzQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yblj9cwn; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-439846bc7eeso13543335e9.3
        for <linux-nfs@vger.kernel.org>; Fri, 21 Feb 2025 05:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740145382; x=1740750182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KoLnMuG5/ikmpmCGRrIozBPyd3426yx3cMx6nyygEJM=;
        b=Yblj9cwnp6yWW6gaqYnAQVvTN0m9IZfb1nCrOPW2DHLZ9mKZjeabl1IfOHKgC+9vzv
         lV0KMEm54TzVzREj42597gDe+Whhoom2h5sS6/v6sZpY120R5e2lC2fFa+lVtrrGV3BA
         bqAhwm9IWoFbTVmsTSjkBOVRvWpku769dHPaYRnW62U7SdeKu2rIhIYnNzmvAFMhTE8o
         m8j9t4oJOvb92hkoKitW2bp8Z3qNzg8RD8YP7/wEIb8igK4SgO+B5HOs6wK8ZGaeHd7t
         WfuOqw3eG0qTbQoyWFuY8mANUZZBQqI409LaqqLNv+9mFvvqXxVTEAXwKOhcfcUH1iuA
         hmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740145382; x=1740750182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KoLnMuG5/ikmpmCGRrIozBPyd3426yx3cMx6nyygEJM=;
        b=SqTsl4qJXJyBf/rPmtn5N0KhjUaub4o/fit5RsYpBCO3lVrW8u95o6p230+qvSAD7B
         k1PeiUAMr5z7xdGUBwi4xm43kFcNZxyQxePdrH8P8jTdRNXATnGwH2Ukbpr1iDRzUpeV
         iKM9uwu7bW+TLdZEHEuVuoBXlIpHET9j/oOYoThaNMwm/Ce7+MfG1pmMzMyP44aiMHCu
         sx6dGj0yNjXcYnBC1tKJ4dN8aQahDPR1vQn1bEbUDbAW4gB/rgjviDypaW4Q01iNFhFC
         s9qZ4G17XPMeziAENUSLcFPLgScelW5rDPidD5TENiYWrJw3Iu++8vNQmFbJANYyl38h
         TbfA==
X-Forwarded-Encrypted: i=1; AJvYcCUE/j+MUzQlI2UreZuGxPkqjPZMPvzuf7kcC4x0yRdU7y3zug61IM8Rb+zmDlLAYAm/c4aU8ys+PDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUlblB+pHqhc+GsJ0mMCS31xdVt4Q27vtyb049wsSBuhbUDBrO
	Ss+p9ZpqI0iT9ryzF+gdAWTGv+VGXLXBjF4TXytcrPlBLU97FqkV
X-Gm-Gg: ASbGncsvvC2lt3b8lsSr7XJUDjBiBH9lW0x8Xq1WLj9k7nIfxpD9lk+Ydg7DS0jVsk8
	EEFPSJSdqlJpwGecjCJjNuMG5JyNJ9KlBcaq+EU3k5jr8IyAysJ9zJVJr8jFq0XLJreTA1FzgP1
	nWZd09SKcORwY/d7VyPD9H2TutBpprYh3ZMAu7AZFsZRG4JFtjiXvFQVAUowJsDn1PXfmk5A6zM
	TnKBJwVwGAh9MJ4L6do8ffnigXNfPC5Udkycq0VpaFDoMcS4RkWy+vi9PsB7mbnfiCZgzX/npuj
	6dRma53Avb/03VWDSegdWLFCQftOFcjoxTgR2UTnYIFkbT69YnDJizcqODU=
X-Google-Smtp-Source: AGHT+IFgbCY6MUExN1EThF7g9R62HKtrykUqptgNeOGMcvZhCF2Fr+T2eJbj1rDBgtqZ48KmrWEYwg==
X-Received: by 2002:a05:600c:a384:b0:439:8a8c:d3ca with SMTP id 5b1f17b1804b1-439ae21d2a0mr27468925e9.29.1740145381480;
        Fri, 21 Feb 2025 05:43:01 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258f8ddbsm23468244f8f.47.2025.02.21.05.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 05:43:00 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id BD10DBE2EE7; Fri, 21 Feb 2025 14:42:59 +0100 (CET)
Date: Fri, 21 Feb 2025 14:42:59 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Baptiste PELLEGRIN via Bugspray Bot <bugbot@kernel.org>
Cc: anna@kernel.org, jlayton@kernel.org, cel@kernel.org,
	herzog@phys.ethz.ch, tom@talpey.com, trondmy@kernel.org,
	benoit.gschwind@minesparis.psl.eu,
	baptiste.pellegrin@ac-grenoble.fr, linux-nfs@vger.kernel.org,
	harald.dunkel@aixigo.com, chuck.lever@oracle.com
Subject: Re: NFSD threads hang when destroying a session or client ID
Message-ID: <Z7iC42RF-7Qj2s4d@eldamar.lan>
References: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
 <20250210-b219710c28-43a3ff2e1add@bugzilla.kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210-b219710c28-43a3ff2e1add@bugzilla.kernel.org>

Hi,

On Mon, Feb 10, 2025 at 12:05:32PM +0000, Baptiste PELLEGRIN via Bugspray Bot wrote:
> Baptiste PELLEGRIN writes via Kernel.org Bugzilla:
> 
> Hello.
> 
> Good news for 6.1 kernels.
> 
> With these patches applied :
> 
> 8626664c87ee NFSD: Replace dprintks in nfsd4_cb_sequence_done()
> 961b4b5e86bf NFSD: Reset cb_seq_status after NFS4ERR_DELAY
> 
> No hangs anymore for me since more than two weeks of server uptime. And previously the hangs occurred every weeks.
> 
> I just see some suspicious server load maybe caused by the send of RPC_RECALL_ANY to shutdown/suspended/courtesy clients.
> 
> I see a lot of work on the list that try to address these problems :
> 
> nfsd: eliminate special handling of NFS4ERR_SEQ_MISORDERED
> nfsd: handle NFS4ERR_BADSLOT on CB_SEQUENCE better
> nfsd: when CB_SEQUENCE gets ESERVERFAULT don't increment seq_nr
> nfsd: only check RPC_SIGNALLED() when restarting rpc_task
> nfsd: always release slot when requeueing callback
> nfsd: lift NFSv4.0 handling out of nfsd4_cb_sequence_done()
> nfsd: prepare nfsd4_cb_sequence_done() for error handling rework
> 
> NFSD: Skip sending CB_RECALL_ANY when the backchannel isn't up
> 
> NFSD: fix hang in nfsd4_shutdown_callback

So I see the backport of 961b4b5e86bf NFSD: Reset cb_seq_status after
NFS4ERR_DELAY landed in the just released 6.1.129 stable version.

Do we consider this to be sufficient to have stabilized the situation
about this issue? (I do  realize much other work has dne as well which
partially has flown down to stable series already).

This reply is mainly in focus of https://bugs.debian.org/1071562

Regards,
Salvatore

