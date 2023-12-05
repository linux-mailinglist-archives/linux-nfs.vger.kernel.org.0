Return-Path: <linux-nfs+bounces-343-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B48D1805F90
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Dec 2023 21:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DDCD1F216ED
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Dec 2023 20:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DF868B7E;
	Tue,  5 Dec 2023 20:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTHK0o14"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F26C6125;
	Tue,  5 Dec 2023 20:37:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DBFC433C7;
	Tue,  5 Dec 2023 20:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701808657;
	bh=OOpK2VzUpLEhcbmCfMt2V+OUAFcy+LXgUCtHVEBz46I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XTHK0o14SjupMjPILWJK+XCrbZDOgfLiqw12ZMZqUi0D3pGhZol2G1/Von9on7EKn
	 X6qgndGQz5feG03hUj8GptuXUWN+DnlmAmmpcOkOKhPAktAcI+brqn8bS7rJ8o+VkQ
	 XFf3cWagaieO5yuPxTfcAT4x7L0lAkLfVNn+laSlyVo4X1iU7T2+3k8J6Pgdpri2eU
	 FRkmGxgiaOhG8Meq76XId+OT8bIw8EWMIbRYr4Ro9T1vPT83PMJNP6Mn2fdiO2SFOJ
	 LWh/fbUal+uQBeKp1OrCpbxP7er2BMLil/lUFvGQwPYrytzdbp3FhJTckJfKbIkmD9
	 lza5FVZ5oX9GA==
Date: Tue, 5 Dec 2023 20:37:33 +0000
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com, neilb@suse.de,
	netdev@vger.kernel.org, jlayton@kernel.org, kuba@kernel.org
Subject: Re: [PATCH v5 3/3] NFSD: convert write_ports to netlink command
Message-ID: <20231205203733.GW50400@kernel.org>
References: <cover.1701277475.git.lorenzo@kernel.org>
 <67251eabfbbccb806991e6437ebcf1cf00166017.1701277475.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67251eabfbbccb806991e6437ebcf1cf00166017.1701277475.git.lorenzo@kernel.org>

On Wed, Nov 29, 2023 at 06:12:45PM +0100, Lorenzo Bianconi wrote:
> Introduce write_ports netlink command similar to the ones available
> through the procfs.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Hi Lorenzo,

some minor feedback from my side.

...

> @@ -1862,6 +1871,87 @@ int nfsd_nl_version_get_dumpit(struct sk_buff *skb,
>  	return ret;
>  }
>  
> +/**
> + * nfsd_nl_listener_start_doit - start the provided nfs server listener
> + * @skb: reply buffer
> + * @info: netlink metadata and command arguments
> + *
> + * Return 0 on success or a negative errno.
> + */
> +int nfsd_nl_listener_start_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	int ret;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_LISTENER_TRANSPORT_NAME) ||
> +	    GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_LISTENER_PORT))
> +		return -EINVAL;
> +
> +	mutex_lock(&nfsd_mutex);
> +	ret = ___write_ports_addxprt(genl_info_net(info), get_current_cred(),
> +			nla_data(info->attrs[NFSD_A_SERVER_LISTENER_TRANSPORT_NAME]),
> +			nla_get_u32(info->attrs[NFSD_A_SERVER_LISTENER_PORT]));

gcc-13 and clang-17 W=1 builds warn that ret is set but otherwise unused in
this function.

> +	mutex_unlock(&nfsd_mutex);
> +
> +	return 0;
> +}
> +
> +/**
> + * nfsd_nl_version_get_dumpit - Handle listener_get dumpit

nit: nfsd_nl_listener_get_dumpit

> + * @skb: reply buffer
> + * @cb: netlink metadata and command arguments
> + *
> + * Returns the size of the reply or a negative errno.
> + */
> +int nfsd_nl_listener_get_dumpit(struct sk_buff *skb,
> +				struct netlink_callback *cb)

...

