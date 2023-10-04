Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233787B869D
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Oct 2023 19:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243497AbjJDRcs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Oct 2023 13:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243433AbjJDRcr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Oct 2023 13:32:47 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1D59E
        for <linux-nfs@vger.kernel.org>; Wed,  4 Oct 2023 10:32:43 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-79fab2caf70so108239f.1
        for <linux-nfs@vger.kernel.org>; Wed, 04 Oct 2023 10:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696440762; x=1697045562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rKXOGT5CRMwFBpLfQ7bu6N50H+dU0TdyuSUnUTcWLb4=;
        b=WQtKT5Fyzq8LTSEm0GIEVsbFSJd8xP3ZViKmCCZ1XwihY9/aqgJ5ZPED1kjORQpaf/
         4qrcGYPp9GElxXnDziDr0EWKBgJJEoRu5gl5T7Br9kGIMycb6HXZTioTwZlAUjmPvOD6
         ybMjypkuTf5aYOdC3PojQSpj5Idsqob/L4pMBjOvcTv7FdY1gR3rUS/FzHDdU+OX0xSq
         w7cMSIHw7DLyyCPcHHCSQVsNaK+erT772cdk7Vg57NyGIn2uk3j755YM4Bi4elA5KI9w
         RQbSbgIxYk1wtIamxyvUU7EmIPH5zRf3U5ZpRidJppGOpciJud8l0W1/rO6XkuHvytPU
         oXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696440762; x=1697045562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rKXOGT5CRMwFBpLfQ7bu6N50H+dU0TdyuSUnUTcWLb4=;
        b=w3lVrhinBvSWWqiuaOu7NMJu79zHrDeo5N24q/O2Nxasq5794fVd89QTnfAVcckECL
         1fty6zj9z+Y1FbJUIXZfC7AKW2BCylNCZ3m55/EhFVC311XeLV58A4vaQ/CYFoftux52
         H56cTCVGduCF0j3bfmOfxKdbVO3ba+Ho8Mx34gdwQDVfkBwHCDeaUi/W2LnXHjGUIihY
         wwpQ/Go6wavBrLXjFPWNrUJRs5MBlDsnc79OCESDeouLANo3Bl+NLkWrR9rlU/oFnYCu
         P7giaTWJ/zYwSaSAFmFLwz6v5rGhKyeFPCoRZm9twbNOeNsUEcsz81L8swDP64KOvikT
         4MkQ==
X-Gm-Message-State: AOJu0YxtSRPQsdFcPpBqoZ+y71k9jNTw2uXAwg+R8vTCRNkrQlu7oP4P
        sfRQXevqJNLyAJsGOV1gB20nkWelOpA=
X-Google-Smtp-Source: AGHT+IGDz3l9D/9usdvsnj7Dp8kJ1r65bFcMXUdImctqMFMD17Z4AgwTjeGNd3QIWnaDGvNaR5j7zA==
X-Received: by 2002:a05:6602:1a07:b0:79d:1c65:9bde with SMTP id bo7-20020a0566021a0700b0079d1c659bdemr3401297iob.1.1696440762655;
        Wed, 04 Oct 2023 10:32:42 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:d99c:94dd:ccd6:fb22])
        by smtp.gmail.com with ESMTPSA id u23-20020a6be417000000b007870289f4fdsm1066598iog.51.2023.10.04.10.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 10:32:41 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/3] nfs-utils: gssd support for KRB5_AP_ERR_BAD_INTEGRITY 
Date:   Wed,  4 Oct 2023 13:32:35 -0400
Message-Id: <20231004173240.46924-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Together with libtirpc patch this series attempts to provide
support for handling KRB5_AP_ERR_BAD_INTEGRITY.

Such error can be returned by the server when it has changed
its key material and the client is still using the service
ticket that was issues prior to the change.

Upon calling authgss_create_default() and receiving a NULL
context, we can inspect the returned structure to see
if gss major/minor error code was set. If the client
determines that it received KRB5_AP_ERR_BAD_INTEGRITY error,
it will proceed to handle it based on what type of credentials
were used for context establishement. If machine credentials
were used, the client can call into a routine and force
credential renewal. If user credentials were used, the client
needs to remove the existing service ticket and then retry
the request.

-- fix compile warning in libtirpc patch

Olga Kornievskaia (3):
  gssd: enable forcing cred renewal using the keytab
  gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for machine credentials
  gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for user credentials

 utils/gssd/gssd_proc.c | 20 ++++++++++++--
 utils/gssd/krb5_util.c | 62 ++++++++++++++++++++++++++++++++++++------
 utils/gssd/krb5_util.h |  4 ++-
 3 files changed, 75 insertions(+), 11 deletions(-)

-- 
2.39.1

