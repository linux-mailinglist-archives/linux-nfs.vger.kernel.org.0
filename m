Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE37B5E6600
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Sep 2022 16:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbiIVOlb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Sep 2022 10:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbiIVOlF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Sep 2022 10:41:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED8685F88
        for <linux-nfs@vger.kernel.org>; Thu, 22 Sep 2022 07:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663857624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lGuJWFaDK89C/tb7QLkSpiiTmHVfm5yBhz4/zZXk9tA=;
        b=fxfwK2/oqese4a0cc4ZzmKf6GPHASlMQrzwtKEYQLMg2NyQR4uh/JVFuNhmOambm/Z+8eE
        5d93CnTiXBHiMUdpKnSnij6Z3u2e3lqHSvO7uwF79mY/kfFzQSBS2fOIfKsnp/qJY4Mv0/
        NKGWOWkhodJmx8E4+rO+uLPixBgjIlM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-Y3Yzh27hMH6himsagKxIGw-1; Thu, 22 Sep 2022 10:40:22 -0400
X-MC-Unique: Y3Yzh27hMH6himsagKxIGw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB5CA383328B;
        Thu, 22 Sep 2022 14:40:21 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.48.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E5FF340C213F;
        Thu, 22 Sep 2022 14:40:20 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Alan Maxwell" <amaxwell@fedex.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [EXTERNAL] nfsv4 client idmapper issue
Date:   Thu, 22 Sep 2022 10:40:18 -0400
Message-ID: <CA53F1A0-807D-4297-9E1E-75E4AA26D470@redhat.com>
In-Reply-To: <DS0PR12MB648637C3D4E07C6FCA90A0E4C84E9@DS0PR12MB6486.namprd12.prod.outlook.com>
References: <DS0PR12MB6486987EC76AD88C7A80D229C84F9@DS0PR12MB6486.namprd12.prod.outlook.com>
 <46FAEBBD-50BC-464B-A983-1DC2232795C5@redhat.com>
 <DS0PR12MB6486B941F1EA96D2634CED63C84E9@DS0PR12MB6486.namprd12.prod.outlook.com>
 <812A1C59-B489-4D6B-8673-15F5C86A99D0@redhat.com>
 <DS0PR12MB648637C3D4E07C6FCA90A0E4C84E9@DS0PR12MB6486.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 22 Sep 2022, at 10:18, Alan Maxwell wrote:

> Again, we would expect ultimately if the server returns error, nfs 
> client should do same, show and error, not change the configuration 
> and ignore our disable_id_mapping.

Not all NFSv4 errors are sent back to userspace, and the meaning of this
error ( I am assuming the server returns NFS4ERR_BADOWNER, a wire 
capture
would verify it ) is to tell the client that it was unable to translate 
the
owner value.  As I understand RFC 8881, that's a clear indication to the
client that the server is not treating the values as numeric uid/gid, it 
is
attempting to map them.  That is why the client changes its behavior.

Besides, what error can the chown syscall possibly return in this case?
Let's say the client /doesn't/ re-enable string-based names. What are 
you
expecting the client to return to userspace?

Ben

