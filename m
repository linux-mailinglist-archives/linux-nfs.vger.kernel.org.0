Return-Path: <linux-nfs+bounces-11116-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2512CA86114
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Apr 2025 16:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAD3F7AA62F
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Apr 2025 14:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357CF207A2D;
	Fri, 11 Apr 2025 14:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOVBpxy/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB261F5858;
	Fri, 11 Apr 2025 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744383179; cv=none; b=Vbro8aHQtAlffcDAekvxu3+F4bMtGJM8J7SUo1Jmx/mMPjCcCSepC00dAUf7ym1q7m3G9mhps6lQ+QZfd129uxd/F3kSNeu3u2Nwdz68NfmtJSqv6cSsi7aSZORelazEdv1E0vbOXyIakutZ8zXoeAsLK2pF6pQxIVbtyg61EvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744383179; c=relaxed/simple;
	bh=YYlILsGyYo5Vq+LNV2/sGtn8ufrLU88MhRh0wxwXRuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OdWLxhDyaklcI1iZYtR3WJWR8Jn+hIxx+G1zMAhj8T59A+Z6vGVSXL4MuKrd2OXX9FFiKFLnyY5qNd2UNi3KIqNpAXfyqS1KsjkC77cW+sfMq0Mcf5RIrKe6mj5aXlmLwW2h9mzu9SQQIEQXuZCLBxboWwY015KP3bNWv7koK0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOVBpxy/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315B9C4CEE2;
	Fri, 11 Apr 2025 14:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744383178;
	bh=YYlILsGyYo5Vq+LNV2/sGtn8ufrLU88MhRh0wxwXRuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LOVBpxy/G4XQpTGo983CC7VQT9aQAG1c5mjQC/ion1+XguF4o2qGzwwYb6vVl8udN
	 HkNTB9+W4M5Mq4aM44dFJ4/Z8UTtX9DvrTEsFIBPvP6LzljTgnMiuzY1PUuWUKNb59
	 IhJKrnsrTdm9LecEcFULMMv216B2nPGn0qknq+3UCCPMRcx3tsNC8I2oNcRXQooJKd
	 fHcruwzE6/pYZi1plA8t4o5e/p2jne3Un1+2+MnD+SGu4FjNKyKz4MNtCcup7IlY5q
	 OCNU7ROCxBPfFB+/S1O/e52vshj1BwvkrSS2JoJ6qbMkkymtfX7KMK4vJ7WdlQYy7B
	 A4q0DPpzD/RVA==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Sargun Dillon <sargun@sargun.me>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 00/12] nfsd: observability improvements
Date: Fri, 11 Apr 2025 10:52:53 -0400
Message-ID: <174438313317.30898.15954352003138182749.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
References: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Wed, 09 Apr 2025 10:32:22 -0400, Jeff Layton wrote:
> While troubleshooting a performance problem internally, it became
> evident that we needed tracepoints in nfsd_commit. The first patch adds
> that. While discussing that, Sargun pointed out some tracepoints he
> added using kprobes. Those are converted to static tracepoints here, and
> the legacy dprintk's removed.
> 
> Lastly, I've updated the svc_xprt_dequeue tracepoint to show how long
> the xprt sat on the queue before being serviced.
> 
> [...]

Applied to nfsd-testing, thanks!

[01/12] nfsd: add commit start/done tracepoints around nfsd_commit()
        commit: f2a3825118e6177f4de5ee9996248ced2918b08b

--
Chuck Lever


