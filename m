Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E386A4FF7AD
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Apr 2022 15:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbiDMNfC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Apr 2022 09:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbiDMNfC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Apr 2022 09:35:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 379D95D5F1
        for <linux-nfs@vger.kernel.org>; Wed, 13 Apr 2022 06:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649856760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=QOJfmSn0xFjav4bRpembNH2O8F44yNE+X3MVGo4gMgI=;
        b=VMO9uLoLl5M+ZnAsxYYfOs5U0M51hfJJcZ3M9oaQdg8YL7qbkEWzHbFrM9W2/Rg+W/O8iB
        /aCk0vGpJiiAwUN280/LA6cXOJA/Nurd/0gsVdNybBsiXyCvWSnxVwZfxMOqdh6wBiJ3IS
        8n61zkaI9AOV05lZbTouqcABzRI3F2E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-178-bys5NBM3OliHpiR_xy9imQ-1; Wed, 13 Apr 2022 09:32:38 -0400
X-MC-Unique: bys5NBM3OliHpiR_xy9imQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C64C803B22
        for <linux-nfs@vger.kernel.org>; Wed, 13 Apr 2022 13:32:38 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B3BE9D4C
        for <linux-nfs@vger.kernel.org>; Wed, 13 Apr 2022 13:32:38 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     linux-nfs <linux-nfs@vger.kernel.org>
Subject: Patches from the list with Content-Type: application/octet-stream
Date:   Wed, 13 Apr 2022 09:32:37 -0400
Message-ID: <1EBC0B18-2233-4467-89E7-4351B4047E95@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Anyone know why the linux-nfs list is setting

Content-Type: application/octet-stream

mail header for patches?  It seems to have started sometime last week, and
makes it difficult for me to quickly read patches.

Ben

