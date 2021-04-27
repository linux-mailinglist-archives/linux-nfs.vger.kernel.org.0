Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8512D36BE8A
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Apr 2021 06:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhD0EnD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Apr 2021 00:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhD0EnD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 27 Apr 2021 00:43:03 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EA4C061574
        for <linux-nfs@vger.kernel.org>; Mon, 26 Apr 2021 21:42:19 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n84so3814602wma.0
        for <linux-nfs@vger.kernel.org>; Mon, 26 Apr 2021 21:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6pSdsPpIU9uN/JJy8DdYBeUcwr55VBNLEgwZAZJ0x4k=;
        b=JycIRdHupJCyJisNoJWoTGhUS5KPxEyouCmNnW8XFELv6fIA6gPyWTcwMSzMV9ENfp
         Ucb9vHJ+IhJGpthas8ZudT226HWga6PyhU2nRj8UDfSKcKsU8O5Re6meBEEwoGvxz25a
         P9YdOLvcj5xfGxMCTcnIp2DqqA14bB1ThHIdCTsN/kIoDeTirSh+IYDGKjWBoT3qY1uy
         a1eQN9Dxo5TAJrLosrWOZiQvw0BPRHt652EnNqFBQw6QqAvyJ/WBGQyE5wZ+2HE/zV1o
         BS+0WnzwWWuDY+37af+57qo90OACUyzMgKAcfPfcxL8IVEEG31fBp7pqufGzk/oe2aZc
         I3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6pSdsPpIU9uN/JJy8DdYBeUcwr55VBNLEgwZAZJ0x4k=;
        b=cjCacIDkfX7RVelrUFYFyTxfUbtqgepWwhRwwVSQ6jAjYNknZA7YnLN//aHfWOpgTQ
         VqcG1dbWkvm5KkSwkE9VicGOxdP1bvJimAf8CqKVRwV3O7NXWosm1eMxJj3+pXl/tD+j
         2cvypI2j1A9LupZGoUlIMSTDskSDSpeNs6lwaqquv0NAWTNWIwzfriklFZATUj8wSLNh
         4vJ206JxP+TxNZsemvcyP96UWiD3Fxew6MkiK57N778n0ne4ScDcXwFJb4kdaDrj435x
         p0zyYQmcJqMoiI3nJvoALU4Z9aAlpU0wRr6F8ZvvAy8N43A22Js1vCKeUW21l36YyyJM
         FbUQ==
X-Gm-Message-State: AOAM530N+sHlC3yl1kIHkDgVTY235lmu5m1Zumzt5pPiA1iE4VIkd/wl
        KTYCSR6R8iXsi86qI43ZNSoFV5ttHs9BmKET
X-Google-Smtp-Source: ABdhPJyx1UJZJmsYsc9HDqqopaWl7j8uiXgVxLO1GLjC3NDGfL2JkC9m+UyHrTecaZSdxQP08Up+PQ==
X-Received: by 2002:a7b:c7c8:: with SMTP id z8mr2231476wmk.112.1619498537917;
        Mon, 26 Apr 2021 21:42:17 -0700 (PDT)
Received: from gmail.com ([77.126.186.5])
        by smtp.gmail.com with ESMTPSA id 3sm9520569wmv.26.2021.04.26.21.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 21:42:17 -0700 (PDT)
Date:   Tue, 27 Apr 2021 07:42:14 +0300
From:   Dan Aloni <dan@kernelim.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3 09/13] sunrpc: add a symlink from rpc-client directory
 to the xprt_switch
Message-ID: <20210427044214.vlbmbfdh5dpq4vhl@gmail.com>
References: <20210426171947.99233-1-olga.kornievskaia@gmail.com>
 <20210426171947.99233-10-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426171947.99233-10-olga.kornievskaia@gmail.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Apr 26, 2021 at 01:19:43PM -0400, Olga Kornievskaia wrote:
> From: Olga Kornievskaia <kolga@netapp.com>
> 
> An rpc client uses a transport switch and one ore more transports
> associated with that switch. Since transports are shared among
> rpc clients, create a symlink into the xprt_switch directory
> instead of duplicating entries under each rpc client.
> 
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>
>..
> @@ -188,6 +204,11 @@ void rpc_sysfs_client_destroy(struct rpc_clnt *clnt)
>  	struct rpc_sysfs_client *rpc_client = clnt->cl_sysfs;
>  
>  	if (rpc_client) {
> +		char name[23];
> +
> +		snprintf(name, sizeof(name), "switch-%d",
> +			 rpc_client->xprt_switch->xps_id);
> +		sysfs_remove_link(&rpc_client->kobject, name);

Hi Olga,

If a client can use a single switch, shouldn't the name of the symlink
be just "switch"? This is to be consistent with other symlinks in
`sysfs` such as the ones in block layer, for example in my
`/sys/block/sda`:

    bdi -> ../../../../../../../../../../../virtual/bdi/8:0
    device -> ../../../5:0:0:0


-- 
Dan Aloni
