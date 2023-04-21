Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F3B6EB111
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Apr 2023 19:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbjDURrm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Apr 2023 13:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbjDURrl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Apr 2023 13:47:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2172211C
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 10:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682099196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TQy1U4yQAlger02P9pusxTZWACgmEB6joKARagpGCxw=;
        b=POUczZRk5VmdUSm3A/ZYK671thrygrk1qGK39TxYywwfR8RU1Ez8Fh/dHVPJ8T2HdJnWLB
        Sh1XSxlKE0nAEnROCTZe8rYgsKyCgp8aKDm4dw7VjAAqgra2rDXShxLi50pkscpQQ8wqzu
        Ri0kXIfiEtCjKxLeT+toUqkNUk+KLQg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-102-pM9n8-L6NfyC62PbPsCNEQ-1; Fri, 21 Apr 2023 13:46:34 -0400
X-MC-Unique: pM9n8-L6NfyC62PbPsCNEQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16B1028082A9;
        Fri, 21 Apr 2023 17:46:34 +0000 (UTC)
Received: from [172.16.193.1] (ovpn-0-3.rdu2.redhat.com [10.22.0.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A0BDC492C18;
        Fri, 21 Apr 2023 17:46:33 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Anna Schumaker <schumaker.anna@gmail.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/9 RFC v2] NFS sysfs scaffolding
Date:   Fri, 21 Apr 2023 13:46:32 -0400
Message-ID: <2D3BC0F1-E7C2-48A1-BFFD-643C0E1738E3@redhat.com>
In-Reply-To: <CAFX2JfnhRv53kSFs5s+QqwVmU2pQShWL_jQSTztMMFvv79=04A@mail.gmail.com>
References: <cover.1682096307.git.bcodding@redhat.com>
 <CAFX2JfnhRv53kSFs5s+QqwVmU2pQShWL_jQSTztMMFvv79=04A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 21 Apr 2023, at 13:37, Anna Schumaker wrote:

> Hi Ben,
>
> On Fri, Apr 21, 2023 at 1:10 PM Benjamin Coddington <bcodding@redhat.com> wrote:
>>
>> Here's another round of sysfs entries for each nfs_server, this time with a
>> single use-case: a "shutdown" toggle that causes the basic rpc_clnt(s) to
>> immediately fail tasks with -EIO.  It works well for the non pNFS cases to
>> allow an unmount of a filesystem when the NFS server has gone away.
>>
>> I'm posting to gain potential NACKing, or to be redirected, or to serve as
>> fodder for discussion at LSF.
>>
>> I'm thinking I'd like to toggle v4.2 things like READ_PLUS in here next, or
>> other module-level options that maybe would be useful per-mount.
>
> I have a patch built on your v1 posting that implements this. I can
> rebase on v2 (well, I guess it'll be v3 now) if you want to see it!

Oh yeah, would love to see it!  I don't think anything changed in the first 6 patches.

Ben

