Return-Path: <linux-nfs+bounces-7188-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4777199F6F1
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Oct 2024 21:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D33C2819A3
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Oct 2024 19:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5751B6CF7;
	Tue, 15 Oct 2024 19:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EW0B90tv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987471F80D5;
	Tue, 15 Oct 2024 19:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019833; cv=none; b=MzKnpcuHFYRiPHZVGGj2oi5LwqWMW2x+u0kkG50g3WkBStE4m7bQcZd4l46J7a6Cr1jsK7lHydVyQZlecsV3xj07+acULhrsP13W+kQrxJJwSHWUe0nkPGfs7k3iPnobnOwsORS14xmeSaGzM+qx/jZhLTCAmithrBM6OK/Lflk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019833; c=relaxed/simple;
	bh=gy9dJBeH5ScgEl9dpk3+6suD4uViQZiESV7AuvO7WgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bDAGaJA3EYRvU4cmGUBw2QWpVfYnxMW8ipRr+Zg5vw9lCufvdKfVW5OoBqaHqhRfse/USZ6Id6CIllsUcjUxFplW1ql98LzdsdLSWdmyEsisQBHatrtLZYtlApvO2lwYXX9S7fKGRbliucVJcif/2G4YVsbgxGpbor2b1ddCwFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EW0B90tv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C18C4CEC7;
	Tue, 15 Oct 2024 19:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729019833;
	bh=gy9dJBeH5ScgEl9dpk3+6suD4uViQZiESV7AuvO7WgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EW0B90tvCB+kNUudE1gi49gKn2y6/72QHX6JInbxMAc+GwgiDPl2fgyLKUnBSNBt/
	 OIZoQxuYGV6HiucKCPJ/rWmfpWV7H8UN5H1n3Sd+MNIhfgnm1x1+F+qq6zXXz45Nmw
	 1OPR3uLBQiPDLHKKu8dU8RBf1h+ORhBZvwV6X0VmjjdV0dBXtCMZVqU5lSCtQcnOJV
	 weBdJ7MpJREr4WnFtkormDoIU5tEN6gKz2JVS+S+3+T1BEbIskSmG+7s/y4wHMh+ju
	 WT1ZYwyVgdbpM0HWFgkhyuP9xmDjLFisHD4DW/ehhcWD+gx9l6mykqXVm1AnlgEVQX
	 eBsIy98/YUG/Q==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Thomas Haynes <loghyr@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/6] nfsd: update the delstid patches for latest draft changes
Date: Tue, 15 Oct 2024 15:17:02 -0400
Message-ID: <172901979223.193241.1019274369673214911.b4-ty@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014-delstid-v1-0-7ce8a2f4dd24@kernel.org>
References: <20241014-delstid-v1-0-7ce8a2f4dd24@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1524; i=chuck.lever@oracle.com; h=from:subject:message-id; bh=NALD/0ArJNhZqM5cNT0+Lzz2k0hxI6C88TM9X16KWIQ=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnDr+vcQdrAAvqAjZvPBa+Fd1CrUdAc486fjxf/ 9lyDbDMPhWJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZw6/rwAKCRAzarMzb2Z/ l7z/EACEe/gxGvXK/AKQ7eJ2KvcOpcTgTORTVizrtcqkUt3q9kMi8TVIziML5BuXM3D+QVXsf9C 3TZ8mJD5p1hWJyhRZf4g4qka+CMfUHxevdzSB+yytRACb6zcKLgvuwVxDgU1ltS4nWXmtG05qLI PS7RrH/Hy67CebESDmCjJlb3yJeJ0Bj6Dpd+9QINrPWCAguXUeH0H1d3VzUVnvZUH8jXp/1RzQa hLWWdcj9HbHeVofH3lsYyz+/DVLMW0UxuCxrWOiuUTJpwDzO+HUgO1jBQRKQMTkU/PE9mxyi6OH cr3UcmK+LJDiv7/sYVIbsHFltJyIrz0+SjFAYynrrLbXik4BwO0VNhEeu78h2UOQktnhWw/WeUD ZMA3Pd5y2jJZn+2N7CvC/3a5HctxAYZbdRtkSRa2aXZ5qnUPQj8hvoLy3KSykLUCrk+ZPUo6Sz9 +EZdJaJfcMrKwbCGcjCfQep4In3sO7fw3jDpwa0ZByV39rBsxxS1XovUEQiVv7e2KCL0udb+Hlc wPhaEiFs44tAe0eEBue/Tblf6Yh4sQhVoHakzWx3r1BP1KubOVLYOa1Q4PrNEn7632RFqCFxGSM VhSaxO2qE7Y77DiS51WaKtIvG36ryFvXK3o5El/n1dys9c3XeFJk/kYEp1RdEhw6ieo05ll83Km sYOxuH
 pcDKAPEbg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 14 Oct 2024 15:26:48 -0400, Jeff Layton wrote:                                              
> This patchset is an update to the delstid patches that went into Chuck's
> nfsd-next branch recently. The original versions of the spec left out
> OPEN_DELEGATE_READ_ATTRS_DELEG and OPEN_DELEGATE_WRITE_ATTRS_DELEG. This
> set adds proper support for them.
> 
> My suggestion is to drop these two patches from nfsd-next:
> 
> [...]                                                                        

Applied to nfsd-next for v6.13, thanks!                                                                

[1/6] nfsd: drop inode parameter from nfsd4_change_attribute()
      commit: aacaab97e76307be16bf147b64dc45c0c9013a8a
[2/6] nfsd: switch to autogenerated definitions for open_delegation_type4
      commit: c1be156cbb5960cf760409416fddbf300b2500c3
[3/6] nfsd: rename NFS4_SHARE_WANT_* constants to OPEN4_SHARE_ACCESS_WANT_*
      commit: 466247e4e33b7e43589e5fa00bcd721a67463935
[4/6] nfsd: prepare delegation code for handing out *_ATTRS_DELEG delegations
      commit: 6dd23bce4068b7ecb26390c81713ab6b617990a3
[5/6] nfsd: add support for delegated timestamps
      commit: 3d342dc5ffe941fed1f6b32ecf59b9b5769f38be
[6/6] nfsd: handle delegated timestamps in SETATTR
      commit: f6b1cfab609da048eba93210f47bf8ef43068119                                                                      

--                                                                              
Chuck Lever


