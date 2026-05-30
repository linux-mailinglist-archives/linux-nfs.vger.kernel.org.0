Return-Path: <linux-nfs+bounces-22096-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Mhc/D7GYGmr65wgAu9opvQ
	(envelope-from <linux-nfs+bounces-22096-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 09:58:41 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7F960BA1A
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 09:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F08B304639D
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 07:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4A2395276;
	Sat, 30 May 2026 07:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qadvf9IL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9994B165F1A
	for <linux-nfs@vger.kernel.org>; Sat, 30 May 2026 07:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780127916; cv=pass; b=tNXwFmQVbZQQH3NzxT2uVZPNQD5Es9A2+evnUCCjUvS4v7NMzWps2xVYQo0cHIjqL7HJD8KsEv4iLolmNViThefwUWqsxCaiBRzXVyRLo37XIcch/NhfcX4rcv6wGB3yvxHEQTGU6hXmQfYvVhO/Rr4yI2ABCVsSaSPBKdCfH4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780127916; c=relaxed/simple;
	bh=nBnp8vqjs2cgqy9R2Xt5sdBV5dhtB84qY2ntdNQA31g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RH6AGobHReydNfAzmGguTlcpmBEJbaWF9FhDzvpVzFVwjn9qN0IP3PN06at2EvKwkd1b+rjD9mxjEQnaAJzE6iiFhAIbjj8Yr8jUPzc2pIdnjWxKzXYMReMSjjerIk4Kdq2tRvyXav9/K6+U9tCecyGvbocf9IzpnF+qlEAo9N0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qadvf9IL; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e615b4c2a7so2164643a34.2
        for <linux-nfs@vger.kernel.org>; Sat, 30 May 2026 00:58:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780127914; cv=none;
        d=google.com; s=arc-20240605;
        b=ZljQq0qnysL0F0fLjNUHjQ3o/ZNeV23KGHANwot/26uvYEriuQxvecEI1nTzQ2hKct
         3UKl9A5+082B4dnxhKMnjtDWTshydvdtXReVysKnsfft+32n+24CBb7/gmLgjF0CcrME
         ++zUQlleQjugaNfK0LJq3NRspelrKtpqMaiwxz9xlSkFP0sfnhFv2Rrr75SEdnqKQOMb
         4UPmAWWvDdZbxIHWnlZMjROwcvO2LkzVTmjspNG+kSyOlk2GzUeJYdKKzraSKF+gm3Dw
         4YO2YWTXX2nw4mS72mUSxGtWhBFCNhSP15ZahmWmFKdulzwGoRco5+MneWr3Op0so+G7
         CFjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0i4u13ynShKhe/h4HEeRUKTrynwkZmy6PiP1RGLKISA=;
        fh=HDqu0Ap1DkUigst/WYGYgk6qfOkf5/0mqSpyeG8DQhU=;
        b=JmEKTr5gCcKfk8AHXAHCR+pPiDvpo9Vjp05ovtC1LGMHlFzQrJD0CiarnjuFkNe50S
         GXU7BbvwfSgGwne/vvk7V/jpFxIGSXx6kwEHcuqjfJ2SSXonZiSqkwj1mg4QvybeTgod
         NjygDf2WESGHNwRFNQi/IeQq67qy35QiscgXVD1RvQ7Q6e6WLNAQh4Yjjzdq/cQxzQPN
         vm3gVsuSggKXu7Xc1+fBk0RBzm3VGFFoQN1ZrJsPVyqLZ10Runxcffk1+iZPjMs0YaMX
         E20KNCLC3Dg74Vp8VvW0yzwXpwqY30QNX2tyCBRj9OyB9H+6cW+3Wuoq0gpOA9aW1HsX
         Ppcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780127914; x=1780732714; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0i4u13ynShKhe/h4HEeRUKTrynwkZmy6PiP1RGLKISA=;
        b=Qadvf9ILDCx0dEbdgPYnPnVgLeCrXLB0DK3J45aSNVtz0BfpBtFw6XraCBeuK4UraC
         nAYNQrR6pEWMl4ZlZ9PEZHAMQZuAt0K7l3ZS7gKiby4qdqojf4i8v2aPAzDRnDxRo1Q9
         cYZhNZ3dITAzlxRY9uHt0UDpQKOfkzyqSRC9ck0uDo2Wp9Mvy0k3IEOcrnafE/wW3UN6
         qAt0l18P8ZJFxaGcPXDlZR1+u+xa5joU6o23uSeEWcaQwEUyKW6wlqhGUx65SjQBi1Vx
         NyIprANwFI7cSDTGrYbvKtixhxr22R61sHO8kI2IYoS/Wn2/odb/V4BBMXE/EhZsvikW
         FF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780127914; x=1780732714;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0i4u13ynShKhe/h4HEeRUKTrynwkZmy6PiP1RGLKISA=;
        b=oNxU7CIEXs1X0qy1D8MW8PjWP5pcz2f+m1IRZnB2hxWMAsQmBfupp7KLBz6yWmeQgA
         8B5TeNtGU5V2DmI57O14SGJ8Y9FT5XMnHHJX7tfK8R7FDyCfiwxbeAzMk3ApYSBUReQ1
         6B7orHIoy684Vv7cBHyseuYkuyQqC752kebfzUBcASnIH21qmWP+EI+XdtU6uNYXVvBC
         W1LgagrVu8zUbeNLjR59Jv18h0f1sTSqCSMIvHESiUTB/gWvPksLmJg7OqX0aFZI/msa
         9+rkcGcPmDiPo9TOUZm9NF+X8sqV53JlwtrqEE1zu+VnyV8uxBmiz72NlsR9CWqHWpNJ
         cOHQ==
X-Forwarded-Encrypted: i=1; AFNElJ9xioHSO/XauLdS5taL+V4WaWqGGKOF90oBP3JcHToXO4XJdjoYNEcemlAF8zBidq2UIZfzBrTrGCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFKHaysdDi0XCTHiAfb6F5mGZ9riifJkuYwA3bJRR3/+pNLea7
	10V+pK3txTYbao0GoWwFv8KYMS8TUq68TFNWK/ZI/vRmJVotOINJg3ILXasEqap5eJtg6WqPHj1
	C2zo6YE86+aPb8XwDoZDnQeoc1Jwf0fs=
X-Gm-Gg: Acq92OF08pdyhzpDf/QB7NQ1hb9HtU7OOJtLmljwa0i+R3Gi/3I6j/v5BLyLyhx/r0T
	3agCiRb0gXPCY/sTHv+tL+ezaBD87pCB2CL4FuSLHuhkrsVD8XGumvWzy8Fz0aof38D0hvAzlBX
	93C2UbJDlOOXi+lsNOKHAAk1qDC1OxRHxRsrmnlR4o7c07tbY+ZgU5KcntrcRy5u4PQAM2z2ZjD
	KFq9V+1Oz6Ybj+OaZ/0CLhWHZv89XXLRlmZBw7heg2DA6w+2a31lHdxI7iD5SrF9Toxh5++RV9P
	5CcPVehjS6uZzX3TfB8=
X-Received: by 2002:a05:6820:6ad0:b0:69b:3a3c:23d0 with SMTP id
 006d021491bc7-69e1038fa2bmr1183851eaf.34.1780127914581; Sat, 30 May 2026
 00:58:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org> <20260528-nfsd-fixes-v1-6-e78708eff77d@kernel.org>
In-Reply-To: <20260528-nfsd-fixes-v1-6-e78708eff77d@kernel.org>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Sat, 30 May 2026 09:58:00 +0200
X-Gm-Features: AVHnY4KhDG1wZf9q9gFci8jpxg286QT1sx2HGbpw7IOR6JCEtrdoW3v8melWoC4
Message-ID: <CALXu0Ud9542MSqpbKTWweoCbwJcX7gnzUW8yDT-2=YCoWLt2dQ@mail.gmail.com>
Subject: NFSv4.1 COMMIT of all changed areas only on flush? Re: [PATCH 06/10]
 NFSD: Enable return of an updated stable_how to NFS clients
To: Jeff Layton <jlayton@kernel.org>, NFSv4 <nfsv4@ietf.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	"J. Bruce Fields" <bfields@fieldses.org>, Scott Mayhew <smayhew@redhat.com>, 
	Trond Myklebust <Trond.Myklebust@netapp.com>, Andreas Gruenbacher <agruen@suse.de>, 
	Mike Snitzer <snitzer@kernel.org>, Rick Macklem <rmacklem@uoguelph.ca>, Chris Mason <clm@meta.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22096-lists,linux-nfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:email];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cedricblancher@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 9E7F960BA1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 29 May 2026 at 00:03, Jeff Layton <jlayton@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> In a subsequent patch, nfsd_vfs_write() will promote an UNSTABLE
> WRITE to be a FILE_SYNC WRITE. This indicates that the client does
> not need a subsequent COMMIT operation, saving a round trip and
> allowing the client to dispense with cached dirty data as soon as
> it receives the server's WRITE response.
>
> This patch refactors nfsd_vfs_write() to return a possibly modified
> stable_how value to its callers. No behavior change is expected.

Question: Could the NFS client just record the write position and
length, and only ask for a COMMIT when a flush is explicitly issued?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

