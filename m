Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B18F3818DB
	for <lists+linux-nfs@lfdr.de>; Sat, 15 May 2021 14:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhEOMnw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 15 May 2021 08:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbhEOMnv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 15 May 2021 08:43:51 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F233C061573
        for <linux-nfs@vger.kernel.org>; Sat, 15 May 2021 05:42:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id s8so1742345wrw.10
        for <linux-nfs@vger.kernel.org>; Sat, 15 May 2021 05:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M5fLUQZ1IaFDhCt/TGY5hpwyIYtyDn0UVsJISN8WBoU=;
        b=2M1HlHPKtyNlya80A8uZL3ibcXMwtP9FwVOAkYl2rFvfbRlDr4+QO/bwI5Lz0E6trh
         TGPuJCiUWGlq5L7/WLsxo/Tb3eLfufH+MbXZd6/1HD9bLcY9QNyzacmHRVsCBVIfZfM8
         xZazjBjbLHcPJrt7pTKzsGx3wS5OSIVwewS4EafD2MPbTME114IpSeUTtBNQHrDxztat
         ORBta45GkUGC4h1ngx5O/FAbOQBF81FsNOUXjdAwj9mxO5uDOS+VHG2VQ4lz5uyiQlsz
         FUzWij0G57XBXeBg2J8yknRS3DOrPrdbpgrXF/ifqpS6Om2MMxZdtPONZ2z9bjLEgamS
         C3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M5fLUQZ1IaFDhCt/TGY5hpwyIYtyDn0UVsJISN8WBoU=;
        b=F09H3KMIAZtzhjhLaNap0oN7fNNIOqw1u9KAqA9q5Z7uDAb8oSsh5/dC/mfrBpvRFd
         CnHgcx12GoZI59EUGk5qpf83glmbMxVbJQyNRfWcXEPnEIGWEmTQWdYMAKhVGzr9ul6M
         Mn71h/lMrlm06B1zPXPYQGUvLfU6CfFXpbkQwNTUJsjUK6fcKJTb0wh75u73Q5QvlnSU
         MfQDsR8ly81am1YkNCTZjDmcLb6AnzZxPO0cOtEbbX0G+gu2zP4Hlw3MXSyY8wo6zHj8
         PXAo6yHManQcFCtI1+1vzF08tiu/UgA20uWp1/t37aQOLeoh3faDbNL80XaT8q3wIrH0
         snuQ==
X-Gm-Message-State: AOAM532c1zZJ7s+aFhpXAIOMyezD6vbyXVBGWhBGAmUEpt9pVbHHfI9L
        vUqjuMclO2zjw6HXi0/b3NGycQ==
X-Google-Smtp-Source: ABdhPJxte41EwmUptBxsRg2iGC8DbfJRnrcg00o4pipSfWAA6Gk1opFt5SHTYC+YZjgPYaeZt9HsBA==
X-Received: by 2002:a5d:4003:: with SMTP id n3mr13830944wrp.173.1621082556121;
        Sat, 15 May 2021 05:42:36 -0700 (PDT)
Received: from gmail.com ([77.124.118.36])
        by smtp.gmail.com with ESMTPSA id c16sm9537056wrn.92.2021.05.15.05.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 05:42:35 -0700 (PDT)
Date:   Sat, 15 May 2021 15:42:32 +0300
From:   Dan Aloni <dan@kernelim.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v7 10/12] sunrpc: add dst_attr attributes to the sysfs
 xprt directory
Message-ID: <20210515124232.y7xmofawebp7l5w6@gmail.com>
References: <20210514141323.67922-1-olga.kornievskaia@gmail.com>
 <20210514141323.67922-11-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514141323.67922-11-olga.kornievskaia@gmail.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, May 14, 2021 at 10:13:21AM -0400, Olga Kornievskaia wrote:
> From: Olga Kornievskaia <kolga@netapp.com>
> 
> Allow to query and set the destination's address of a transport.
> Setting of the destination address is allowed only for TCP or RDMA
> based connections.
> 
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
..
> +	saddr = (struct sockaddr *)&xprt->addr;
> +	port = rpc_get_port(saddr);
> +
> +	dst_addr = kstrndup(buf, count - 1, GFP_KERNEL);
> +	if (!dst_addr)
> +		goto out_err;
> +	saved_addr = kzalloc(sizeof(*saved_addr), GFP_KERNEL);
> +	if (!saved_addr)
> +		goto out_err_free;
> +	saved_addr->addr =
> +		rcu_dereference_raw(xprt->address_strings[RPC_DISPLAY_ADDR]);
> +	rcu_assign_pointer(xprt->address_strings[RPC_DISPLAY_ADDR], dst_addr);
> +	call_rcu(&saved_addr->rcu, free_xprt_addr);
> +	xprt->addrlen = rpc_pton(xprt->xprt_net, buf, count - 1, saddr,
> +				 sizeof(*saddr));

Hi Olga,

How does this behave if rpc_pton fails? Perhaps this conversion being
also a validation check on input given from user-space should be done
before the xprt is being modified?

-- 
Dan Aloni
