Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390FF5E64AC
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Sep 2022 16:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiIVOGi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Sep 2022 10:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiIVOGg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Sep 2022 10:06:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1065E9CD3
        for <linux-nfs@vger.kernel.org>; Thu, 22 Sep 2022 07:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663855595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uuLGcoQiYoOVTxw2WfYVAvz1INh8CDw8el3VbZCEysE=;
        b=jQvtbbo+svjlpCcsepxhui/nZmlwpGtI3Xth11oRTbkXW9yOC+m9vp50f2WIY3A4Z4m/NN
        ayod0Z9gY19cv4HReUDfM+OXoOKeOB26e66WNST30o3exb8gnxQ+ziEHHquKncJES2pjgG
        +g2FTWnkTOKPs112RKK8mz1+c9wOAwo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-448-6gd_s3P2O0CtsrCEuHgsVw-1; Thu, 22 Sep 2022 10:06:31 -0400
X-MC-Unique: 6gd_s3P2O0CtsrCEuHgsVw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A320185A7AA;
        Thu, 22 Sep 2022 14:06:31 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.48.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 069ED41F37E;
        Thu, 22 Sep 2022 14:06:30 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Alan Maxwell" <amaxwell@fedex.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [EXTERNAL] nfsv4 client idmapper issue
Date:   Thu, 22 Sep 2022 10:06:29 -0400
Message-ID: <812A1C59-B489-4D6B-8673-15F5C86A99D0@redhat.com>
In-Reply-To: <DS0PR12MB6486B941F1EA96D2634CED63C84E9@DS0PR12MB6486.namprd12.prod.outlook.com>
References: <DS0PR12MB6486987EC76AD88C7A80D229C84F9@DS0PR12MB6486.namprd12.prod.outlook.com>
 <46FAEBBD-50BC-464B-A983-1DC2232795C5@redhat.com>
 <DS0PR12MB6486B941F1EA96D2634CED63C84E9@DS0PR12MB6486.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 22 Sep 2022, at 9:45, Alan Maxwell wrote:

> How would the server know what gidNumber to assign if the nfs client sent
> a name?

I'm not familiar with this server, but I'm guessing if you have it set to
"Do not send names", then it also will try not to translate uid/gids it
receives.  Are you asking a theoretical question?

> Is there a method in Redhat to have the nfsclient only send
> uidNumbers/gidNumbers?

Better to use Red Hat's support for these type of questions because this
list is mostly upstream development work, but I believe that's the point of
nfs4_disable_idmapping which exists on that kernel.

> Doing id mapping or better name , id verification, is expected. We hope
> the server would tell us, "client sent name I can't verify or lookup"

Right, and that is a signal to the client that the server is not doing the
"Do not send names" thing, rather trying to map values, so the client
changes its behavior.

If you're only sending integer gid values, what does it mean to verify a
group id?  If you want your server to treat the values as integer gids, then
it shouldn't return an error that means "I couldn't translate this into a
gid".

> The nfsclient  sends both a bad name and bad gidNumber, we actually think
> that should be the case, even and security=sys , there should be
> validation of users and groups.

I'm sorry, I don't understand what you trying to say here.

Ben

