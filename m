Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EB3750A58
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jul 2023 16:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjGLOBg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Jul 2023 10:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbjGLOB3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Jul 2023 10:01:29 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E26B1FC0;
        Wed, 12 Jul 2023 07:01:15 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 9981D5C00CC;
        Wed, 12 Jul 2023 10:01:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 12 Jul 2023 10:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1689170472; x=1689256872; bh=pijrPuuLOBTkT
        DRF45Xzk2tpR/dfYgIqP4aKL7wG5i4=; b=B29H8pAiq8a97xvx1/lC2W9LSIuf7
        k/XhDgqZER5cGPHRnGB0iucs6Bl8MxTjLN2gW7ixpIrPaxlilhBYsPHFA0O9QIij
        dGDvkc0sKbYCqHQ3/7ldaNOkg5PNyKC6rsON5/7Y9ojihkkM57DskkTHkwyau0Fy
        A4i3jwhl5LlZcX6hBs5Hha5wtV2ty/66Sjne2iN/PLW79oHAfD/jjQM03ndkF8eS
        3lAFneZ4Bho6yz4lMAoq6HPYeAJ6VQMIhmj28wMItZE5iRWx/0NTiX9AYshFI2dP
        fEsNxuQ60SuRgu1TVkdREos3lJ/E4lyPV2dhNLFu5MWkYHGHmkQOXVocQ==
X-ME-Sender: <xms:J7KuZGaCS3BzZhMmTdC6TIIJ1LAsR9Qx1YniX3BZ35Sv3aFGkuBVlA>
    <xme:J7KuZJZFTJkqvgtyRFieub_QVuwfMlzgzCYTyx9d19FDAAq79mrl4CgIz2qOO8Pq5
    ygMTyLJYYw4J_s>
X-ME-Received: <xmr:J7KuZA-9pv0U85TpDz8OfBlxRsabUp3ci8_4kh3fWoX9lfdR3MQvh6eZrqc0Sffl4Y805eL3In-rwV5C5a4w0lwmDF8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfedvgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpeehhfdtjedviefffeduuddvffegteeiieeguefgudffvdfftdefheeijedthfej
    keenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:J7KuZIplkV5mY6R0ceYvXN6Cib-T_VPEhYrApXYD_si5ZkLDq_KIvw>
    <xmx:J7KuZBr8nWguMwjwi8e70jjyXFXJ8Ei886KJs-gfC7s3jUJQ4SOYKg>
    <xmx:J7KuZGRPovAh04AXQf3p4Fcl8pN0U1leimO8nxIzbEubQvi7o4GiiQ>
    <xmx:KLKuZIW9V08DcHJvKM8DgGDOp6en5HW9sLbp_qaNgzDtXuTxEGyteA>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jul 2023 10:01:10 -0400 (EDT)
Date:   Wed, 12 Jul 2023 17:01:07 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Wenchao Hao <haowenchao22@gmail.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wenchao Hao <haowenchao2@huawei.com>
Subject: Re: [PATCH] NFS: Fix memleak in nfs_sysfs_move_sb_to_server
Message-ID: <ZK6yI4BO+csaxGkZ@shredder>
References: <20230712134853.1044134-1-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712134853.1044134-1-haowenchao2@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jul 12, 2023 at 09:48:53PM +0800, Wenchao Hao wrote:
> call kfree() to free memory allocated in kasprintf() to fix
> memleak. It's easy to recurrent this memleak, just mount and
> remount nfs at NFS client.
> 
> The bug is detected by kmemleak with following stack:
> unreferenced object 0xffffa31a91fdf2c0 (size 16):
>   comm "mount.nfs", pid 960, jiffies 4294724478 (age 111892.067s)
>   hex dump (first 16 bytes):
>     73 65 72 76 65 72 2d 30 00 f2 fd 91 1a a3 ff ff  server-0........
>   backtrace:
>     [<00000000de9b21a9>] create_object+0x11/0x17
>     [<00000000ed17aa96>] kmemleak_alloc+0x6c/0x7a
>     [<000000009f4acc69>] slab_post_alloc_hook.constprop.0+0x81/0x99
>     [<00000000d2446455>] __kmem_cache_alloc_node+0x10c/0x13a
>     [<00000000eca4a704>] __kmalloc_node_track_caller+0x83/0xb7
>     [<0000000076cdb22f>] kvasprintf+0x65/0xc3
>     [<00000000f6f2e879>] kasprintf+0x4e/0x69
>     [<00000000e49d03be>] nfs_sysfs_move_sb_to_server+0x24/0x5f
>     [<0000000039127597>] nfs_kill_super+0x25/0x49
>     [<00000000e6ecf809>] deactivate_locked_super+0x35/0x74
>     [<000000003b9c3350>] deactivate_super+0x3c/0x44
>     [<00000000777c86be>] cleanup_mnt+0x6c/0xe7
>     [<000000009f181749>] __cleanup_mnt+0x12/0x18
>     [<00000000a709602e>] task_work_run+0x75/0x8c
>     [<0000000075da06ba>] exit_to_user_mode_prepare+0x79/0x102
>     [<0000000093a53d48>] syscall_exit_to_user_mode+0x1c/0x30
> 
> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
> ---
>  fs/nfs/sysfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
> index acda8f033d30..bf378ecd5d9f 100644
> --- a/fs/nfs/sysfs.c
> +++ b/fs/nfs/sysfs.c
> @@ -345,8 +345,10 @@ void nfs_sysfs_move_sb_to_server(struct nfs_server *server)
>  	int ret = -ENOMEM;
>  
>  	s = kasprintf(GFP_KERNEL, "server-%d", server->s_sysfs_id);
> -	if (s)
> +	if (s) {
>  		ret = kobject_rename(&server->kobj, s);
> +		kfree(s);
> +	}
>  	if (ret < 0)
>  		pr_warn("NFS: rename sysfs %s failed (%d)\n",
>  					server->kobj.name, ret);

A fix was already posted:

https://lore.kernel.org/linux-nfs/6702796fee0365bf399800326bbe6c88e5f73f68.1689014440.git.bcodding@redhat.com/
