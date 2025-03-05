Return-Path: <linux-nfs+bounces-10477-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F574A501BA
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Mar 2025 15:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A96B317495C
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Mar 2025 14:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF40324FBFB;
	Wed,  5 Mar 2025 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOvavE7W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF3224FBE5
	for <linux-nfs@vger.kernel.org>; Wed,  5 Mar 2025 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741184392; cv=none; b=VU39QaN+dj1dfeJmQHzP7CsQXgIBgEgP+4GkdoOZTS6KoK6RCSJ4CHW66jI6CmGbkhh3YdnH6qRgwYZkuIavF/NJPr8Ade2qIWZlZv00A1htZ0YVvyY+kNrlYdh44d6JIlUj6RDLy9omVATKlmsLMJnvIQFYCODEIACZtvh9hvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741184392; c=relaxed/simple;
	bh=88KxjFRjQQL1ngJ7Bwygb7+T3EqmyiAcJDNEzZXEOg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hJiEyg6SZrGrwoYFEuDcGLL7TfLHceUAHdDDMNZUVjjPM86PbZ8C2iar4u52fyh1ukvDEAmYmu/I/hUgS0wsPgtw/zpHK4cwd5tQqpaRIcCMd8CQZ1be3HKEQ0MXHrieDFnikb9MyVrTgS0mXsLHqR1wXYF61cGL4S2MDKm3Vb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOvavE7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BEA9C4CEEB;
	Wed,  5 Mar 2025 14:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741184392;
	bh=88KxjFRjQQL1ngJ7Bwygb7+T3EqmyiAcJDNEzZXEOg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hOvavE7WzOj/HmH8y+C+UaRSK5akwYbM1Q5nuyfPYC6JpKkaYz4L5ScTSly19VqZp
	 6aVDwq4wlFt9FuAjhIbP4g0iRb/JgxYH/PhiUevLXr+leVYUsr/ZFtWk1LAXvcuqnC
	 HXURlt0fcuflcMbB89zp9twBKfRCbuGGmbjEDsiJCLhYxbsS32OjJEX8MmOrpXqji3
	 cg/HqYIW2EJzjl8llDhgnLoMz0GvgoAnqWzsRjSkMz/lN8l/ZCIk4F5kZcd3gWnKMv
	 ZNbEPsulkkzcFFcOMB6qxhEhj9jruEoByRlWoG7SGrUVeMxhsBoyj+OnpeUWjv3myb
	 aeriREu9pelpg==
From: cel@kernel.org
To: jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	tom@talpey.com,
	Dai Ngo <dai.ngo@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	sagi@grimberg.me
Subject: Re: [PATCH V4 0/2] NFSD: offer write delegation for OPEN with OPEN4_SHARE_ACCESS only
Date: Wed,  5 Mar 2025 09:19:48 -0500
Message-ID: <174118423604.42220.17310245847640985775.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <1741120693-2517-1-git-send-email-dai.ngo@oracle.com>
References: <1741120693-2517-1-git-send-email-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Tue, 04 Mar 2025 12:38:11 -0800, Dai Ngo wrote:
> >From RFC8881 does not explicitly state that server must grant write
> delegation to OPEN with OPEN4_SHARE_ACCESS_WRITE only. However there
> are text in the RFC that implies it is up to the server implementation
> to offer write delegation for OPEN with OPEN4_SHARE_ACCESS_WRITE only.
> 
> Section 9.1.2:
> 
> [...]

Applied to nfsd-testing, thanks!

Hoping to get some testing experience on this series while review is
ongoing.

[1/2] NFSD: Offer write delegation for OPEN with OPEN4_SHARE_ACCESS_WRITE
      commit: a6a3093e768e143d4a6088db2b4ec91097302fe5
[2/2] NFSD: allow client to use write delegation stateid for READ
      commit: 14d6ad10126cf89b64a889467844b4c1ef588f7d

--
Chuck Lever


