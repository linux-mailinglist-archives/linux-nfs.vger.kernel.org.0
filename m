Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB48A5E665C
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Sep 2022 17:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiIVPBm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Sep 2022 11:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiIVPBl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Sep 2022 11:01:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9520B6024
        for <linux-nfs@vger.kernel.org>; Thu, 22 Sep 2022 08:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663858900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+GOlhaLEUr0K8wab5O5NZ+KMTLlHYcVEaTsRKaMnGqY=;
        b=GEBk4NLbN3x40RM/uCG5oJhD9UeW8mJOkp2bka8EsxwE5vR4oKdqCEidrvAk9Z+VnMh/7G
        ndLy70hresEgq3CUPyaE8Q3kxNeS4HxljsQ8Pti+2bGG8nwkgJgPuACBHac31Y2sduZiHu
        VQaHmubFo2nVBAkQIPCOHZMOcuUT1MU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-If89GXePNBKlnxceZ3vb3Q-1; Thu, 22 Sep 2022 11:01:38 -0400
X-MC-Unique: If89GXePNBKlnxceZ3vb3Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F8331C1A948;
        Thu, 22 Sep 2022 15:01:37 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.48.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E67F71121315;
        Thu, 22 Sep 2022 15:01:36 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Alan Maxwell" <amaxwell@fedex.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [EXTERNAL] nfsv4 client idmapper issue
Date:   Thu, 22 Sep 2022 11:01:35 -0400
Message-ID: <D881148A-3521-47D3-873B-C244969B0599@redhat.com>
In-Reply-To: <DS0PR12MB6486A843F54547C497E6064AC84E9@DS0PR12MB6486.namprd12.prod.outlook.com>
References: <DS0PR12MB6486987EC76AD88C7A80D229C84F9@DS0PR12MB6486.namprd12.prod.outlook.com>
 <46FAEBBD-50BC-464B-A983-1DC2232795C5@redhat.com>
 <DS0PR12MB6486B941F1EA96D2634CED63C84E9@DS0PR12MB6486.namprd12.prod.outlook.com>
 <812A1C59-B489-4D6B-8673-15F5C86A99D0@redhat.com>
 <DS0PR12MB648637C3D4E07C6FCA90A0E4C84E9@DS0PR12MB6486.namprd12.prod.outlook.com>
 <CA53F1A0-807D-4297-9E1E-75E4AA26D470@redhat.com>
 <DS0PR12MB6486A843F54547C497E6064AC84E9@DS0PR12MB6486.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 22 Sep 2022, at 10:50, Alan Maxwell wrote:

> I would expect chgrp to behave similar to a local file system:
> chgrp badgroupname junk
> chgrp: invalid group: 'badgroupname'

That's not the filesystem giving you that error, that's the chgrp binary
trying to translate the argument into a gid.

