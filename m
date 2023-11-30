Return-Path: <linux-nfs+bounces-181-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E20067FE4CE
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 01:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E576B20EB8
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 00:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31E5386;
	Thu, 30 Nov 2023 00:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0RxJBOp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28DF180;
	Thu, 30 Nov 2023 00:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123FDC433C8;
	Thu, 30 Nov 2023 00:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701304114;
	bh=fTSuT5wA8dpg7BcKfttSF75nApcqaZadiuhJ8Et0cNQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A0RxJBOpzFknhyJF6QWAhp/TTPuiExYeK3Hq75s9+XbWvvLBESysNUt4Rvt8Px5De
	 /h6VH/YQuPL7KN/3s8hFwiRdjjtjOsx0vPRPRgr4wB66eXNVbh1TTEaEbdln8nRTO2
	 HIkBDEO9UW+6TJTHNDCzym17HmnHugiZFodM8nIPusM6Oxfhg34YOSw1XWa3xQ+tKa
	 WM6Cl39XoqeUUzGAKfSTF18irqsNR8akjzMwizLGMfvKnvghnnKj3pltZcoZT0O/ur
	 0floqKQgUzPvl4ns8AuYegwvea3aVymSs1TKa2l9f4ctRt480K3TulA6ton34NXzUK
	 0ke09jVFg9Www==
Date: Wed, 29 Nov 2023 16:28:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com, neilb@suse.de,
 netdev@vger.kernel.org, jlayton@kernel.org
Subject: Re: [PATCH v5 2/3] NFSD: convert write_version to netlink command
Message-ID: <20231129162832.4b36f96b@kernel.org>
In-Reply-To: <8b47d2e3f704066204149653fd1bd86a64188f61.1701277475.git.lorenzo@kernel.org>
References: <cover.1701277475.git.lorenzo@kernel.org>
	<8b47d2e3f704066204149653fd1bd86a64188f61.1701277475.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Nov 2023 18:12:44 +0100 Lorenzo Bianconi wrote:
> +      -
> +        name: status
> +        type: u8

u8? I guess...

> +/**
> + * nfsd_nl_version_get_doit - Handle verion_get dumpit

doesn't match the function name (do -> dump)

> +			/* NFSv{2,3} does not support minor numbers */
> +			if (i < 4 && j)
> +				continue;
> +
> +			if (i == 4 && !nfsd_minorversion(nn, j, NFSD_TEST))
> +				continue;
> +
> +			hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
> +					  cb->nlh->nlmsg_seq, &nfsd_nl_family,
> +					  0, NFSD_CMD_VERSION_GET);

Why not iput()?

> +			if (!hdr)
> +				goto out;
> +
> +			if (nla_put_u32(skb, NFSD_A_SERVER_VERSION_MAJOR, i) ||
> +			    nla_put_u32(skb, NFSD_A_SERVER_VERSION_MINOR, j))
> +				goto out;
> +
> +			genlmsg_end(skb, hdr);
> +		}
> +	}

