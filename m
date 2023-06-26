Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF7373EEA5
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Jun 2023 00:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjFZWZQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Jun 2023 18:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjFZWZP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Jun 2023 18:25:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A59112A
        for <linux-nfs@vger.kernel.org>; Mon, 26 Jun 2023 15:25:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30A5760EC7
        for <linux-nfs@vger.kernel.org>; Mon, 26 Jun 2023 22:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58240C433C0;
        Mon, 26 Jun 2023 22:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687818313;
        bh=5mQQwq0Z3OZ6GVBn9t1gHF86fkRaALdm7JUMSe7jOpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ERdjs0BtIwUKhfVo8Q3ksZBd9pDMd/lK0/bL5lVPn7cUsNx3uBVRKN3cYANNZz6HJ
         nPhKBTgYdFUEjLx1VerUUr3u6hhdkR/OlO/mPE0edRZlm96RmJd0pYqp/dXNri8nIs
         B2otwRRfowmCNn2Bh2Pq8Q0tdFsWNT9e7cmxkRSeOC08pG8730H83bnllmgZWUdyLY
         wi5evp3riBp8cvKcLhZc+ep+VhHpfkp0KoOlXQzaXFY//3ItrA0m+TE8PWI+G35MJ/
         4dx/uPjbeVkvF3DRgfJ70gCv/00mpbskV76jRkFi3eYNfiIOxwFcVN8Oe83bCI5DOC
         KQwfyfAJa6c9w==
Date:   Mon, 26 Jun 2023 15:25:11 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     linux-nfs@vger.kernel.org, Trond Myklebust <trondmy@gmail.com>
Subject: Re: [PATCH v4 05/11] NFS: add superblock sysfs entries
Message-ID: <20230626222511.GA508950@dev-arch.thelio-3990X>
References: <cover.1686851158.git.bcodding@redhat.com>
 <095dda5e682c8367335b9fa448f2834b9435ee69.1686851158.git.bcodding@redhat.com>
 <20230626211223.GA3771155@dev-arch.thelio-3990X>
 <BB4C7A5D-BC97-4422-B5DE-D9267EB29882@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BB4C7A5D-BC97-4422-B5DE-D9267EB29882@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jun 26, 2023 at 05:47:21PM -0400, Benjamin Coddington wrote:
> On 26 Jun 2023, at 17:12, Nathan Chancellor wrote:
> 
> > Hi Benjamin,
> >
> > On Thu, Jun 15, 2023 at 02:07:26PM -0400, Benjamin Coddington wrote:
> >> Create a sysfs directory for each mount that corresponds to the mount's
> >> nfs_server struct.  As the mount is being constructed, use the name
> >> "server-n", but rename it to the "MAJOR:MINOR" of the mount after assigning
> >> a device_id. The rename approach allows us to populate the mount's directory
> >> with links to the various rpc_client objects during the mount's
> >> construction.  The naming convention (MAJOR:MINOR) can be used to reference
> >> a particular NFS mount's sysfs tree.
> >>
> >> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> >
> > I am not sure if this has been reported or fixed already, so I apologize
> > if this is a duplicate. After this change landed in -next as commit
> > 1c7251187dc0 ("NFS: add superblock sysfs entries"), I see the following
> > splat when accessing a NFS server:
> 
> Hi Nathan, oh yes - I see there are a few paths through nfs4_init_server()
> where we can exit early due to an error or duplicate client, in which case
> nfs_free_server() tries to clean up the server kobject before it has been
> initialized.
> 
> I think we can simply do:
> 
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index 4967ac800b14..4046072663f2 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -1013,8 +1013,10 @@ void nfs_free_server(struct nfs_server *server)
> 
>         nfs_put_client(server->nfs_client);
> 
> -       nfs_sysfs_remove_server(server);
> -       kobject_put(&server->kobj);
> +       if (server->kobj.state_initialized) {
> +               nfs_sysfs_remove_server(server);
> +               kobject_put(&server->kobj);
> +       }
>         ida_free(&s_sysfs_ids, server->s_sysfs_id);
> 
>         ida_destroy(&server->lockowner_id);
> 
> Are you able to test that?  If not, totally fine - I think I should be able
> to reproduce the problem and send a patch.

Yes, that appears to work for me! Feel free to add

Tested-by: Nathan Chancellor <nathan@kernel.org>

to that diff if you send it along formally.

Cheers,
Nathan
