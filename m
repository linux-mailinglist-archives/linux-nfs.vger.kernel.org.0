Return-Path: <linux-nfs+bounces-10256-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B23A3F74F
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 15:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C90519C5B45
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 14:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2A82BD04;
	Fri, 21 Feb 2025 14:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MN0CDgp1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3C453AC
	for <linux-nfs@vger.kernel.org>; Fri, 21 Feb 2025 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740148323; cv=none; b=QDInNvq7T4BSryW9IripcGE1eQC7C+S3KZuf29AhQYPitN0/wAgLqbrKJDbHblGye7cvm9qd1EtIxRfxvm/5wuci6gzbAvyBFJ+VaRRFfNt5NXE77O4ab/3btwOGOoqytYx1DLT7Mws89SC9r5OeQOD2VZCUmUIXZs/v/Y9khMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740148323; c=relaxed/simple;
	bh=7VmE64LjjmTveGsVW0N5fe0QWx12wCNjK5Z56qhAa5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/NP8S7PK1mdFmZwbUtkS7Ph4CYBTs5/kr5QdjxmC5e8+mGzGxxetmNuLtCnnYM20lO/OUrtDsM9UjSjNbDarde0QuOEvl0mfZ4z7/1IAqcYJfv0ndCMltGTq0xkccvr94/4+8cB27UYw3tCAO5GppyzVcVD/gAqAQjihTwm79M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MN0CDgp1; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38f286b5281so1093690f8f.1
        for <linux-nfs@vger.kernel.org>; Fri, 21 Feb 2025 06:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740148320; x=1740753120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ckjEL7JApn43a1GxUYZsDx4cOXZMckF5N3nYR9o+F/k=;
        b=MN0CDgp14OzdVEJNqPLT10cJUOdVK5+FVML3ThV5/7xFgdd//k5U7aJnxnw8croKNT
         8TG3FVMGHu+KVVXv8NLWhAgQEUdNGwkRrFtpPT3SBCA+9WzxoUiqYkqFuJvdkABUegh+
         FYhh+KqvnQQgvakA89ShlrgY/xiYHvXG9PgzTCsQj51+yiVtkLxFXrIB7Zgc7X2nNR9g
         hws0hKobB0zBY6SA8vTaD6NRxPiTmHeK20EJ6ZDJ/nkB0lnIGtAuw+90yh3S6CNNiLKA
         eJH4kS2I1vPUAvFq+NBK1g04zZ5GbEBmnh5C3I8HVGA8gzlnjb5DUujas9LKMZNq7F9e
         79YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740148320; x=1740753120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckjEL7JApn43a1GxUYZsDx4cOXZMckF5N3nYR9o+F/k=;
        b=I8IDGVRkFrpmf/D9wZmeY9Hhs02iGtqyWgl9fzPjZpCEKge4RWVTgVyWanUoyTE8IX
         gPgDkW10CNKi2GKVkCl2ORZh0e4TOgcBSjZE77OdddmGZrPmOBG7HXFdulH1AiCe8NjU
         OhBRXcGKjeKDpksHYw9rKayWGZnylWDq/6dz5ViwhrgYWbjBpbfGjhmG1b6ARzBvq+gW
         rsbDnVJ58MHWsJlgeC9CvD1HuRBoVbdcNFRFmi9of8Wi0SDhqr1C+jpDMOvEX/VjxKuC
         SZyPdT24B0aau80G+0Qbw1ES1hVGWP93cYVw3xg33NMKj9tT27UIJRK9i2fnaoXNMxlY
         6LFw==
X-Forwarded-Encrypted: i=1; AJvYcCUxSL75dPMCS/r4PsHtjGzTFNQPwy7Le+pQAbGxR3QZHBaNYH73Ix1XfMMJaV00cNNtZJUcua7ppbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyw/Mkw8PVZoAbroXOr6LrQ9gMmWhpEOrMmR9mtdwl3N7ULqHN
	GCpFGod/aF21BcVSCmsqCil1dwEfkyIJzNxrDBg2wF+l2Y6vkoZf
X-Gm-Gg: ASbGncsOOoe7XE8z5cx1G2/+NYANdKGMzxeRi30TQ3UUEdt3EHlEhmiN6d3v7/DOolG
	gZKc0xmnCksqb16bz2FPOKIlUFkqfNX6GW4/88dYZ9dsFA3vYQbSXwkaxHN9GvlAPw9cGGww1xW
	M8G1eEJEr473tGwGfuw3/f1SDeRdah2r0jhdXTmfY1bQjmbGZcbE/aonDwylQ8Fz+YxeJ9OUGWB
	NroaXG/v68iuXzEc91iIaMctUjU6YRBYjzV7FZCM8l6m+wMCx//fhGo3dtuC3f2AhO84K1XJ2/X
	oK/Ypw4ifpNnpV+FhDk8gCqc+BlUyFWIHJcZ7DoqocVDFY48fUoaAVYPvto=
X-Google-Smtp-Source: AGHT+IEIXGYHkM4NfrR67Nm1mz5ebG/AAba66eVK/skSr2n/49QPSVeedOpjPyc2+b//PcfTKRkn8g==
X-Received: by 2002:a5d:5f51:0:b0:38d:dffc:c133 with SMTP id ffacd0b85a97d-38f70827ad7mr2950943f8f.44.1740148319876;
        Fri, 21 Feb 2025 06:31:59 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4399bea8577sm67070845e9.0.2025.02.21.06.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 06:31:59 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 3C0F2BE2EE7; Fri, 21 Feb 2025 15:31:58 +0100 (CET)
Date: Fri, 21 Feb 2025 15:31:58 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Harald Dunkel <harald.dunkel@aixigo.com>
Cc: Baptiste PELLEGRIN via Bugspray Bot <bugbot@kernel.org>,
	"anna@kernel.org" <anna@kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>,
	"cel@kernel.org" <cel@kernel.org>,
	"herzog@phys.ethz.ch" <herzog@phys.ethz.ch>,
	"tom@talpey.com" <tom@talpey.com>,
	"trondmy@kernel.org" <trondmy@kernel.org>,
	"benoit.gschwind@minesparis.psl.eu" <benoit.gschwind@minesparis.psl.eu>,
	"baptiste.pellegrin@ac-grenoble.fr" <baptiste.pellegrin@ac-grenoble.fr>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: NFSD threads hang when destroying a session or client ID
Message-ID: <Z7iOXnzzMKBYEQA3@eldamar.lan>
References: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
 <20250210-b219710c28-43a3ff2e1add@bugzilla.kernel.org>
 <Z7iC42RF-7Qj2s4d@eldamar.lan>
 <PR3PR01MB69723701495481CCA7D55F0585C72@PR3PR01MB6972.eurprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PR3PR01MB69723701495481CCA7D55F0585C72@PR3PR01MB6972.eurprd01.prod.exchangelabs.com>

Hi Harry,

On Fri, Feb 21, 2025 at 01:57:47PM +0000, Harald Dunkel wrote:
> Hi folks,
> 
> I don't like to bring bad news, but yesterday I had a problem with
> kernel 6.12.9 (twice), see attachment. AFAIK 6.12.9 is supposed to
> include 961b4b5e86bf56a2e4b567f81682defa5cba957e and
> 8626664c87eebb21a40d4924b2f244a1f56d8806.

At first glance this looks like a different issue, as the backtrace
does ot mention at all nfsd4_destroy_session but I will leave it to
Chuck et all as the experts to correft me if I'm asserting this
wrongly.

Regards,
Salvatore

