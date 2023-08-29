Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF6478CD74
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Aug 2023 22:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbjH2UTa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Aug 2023 16:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240512AbjH2UTI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Aug 2023 16:19:08 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB431BC
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 13:19:05 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-77dcff76e35so50235039f.1
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 13:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693340345; x=1693945145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UUpY2VL3S9CLj7f7/TQ8oC3zq6bYGzeqnah/K/J6KSU=;
        b=beJ+kUXdLkIX8iYy28N2UeEF7tfd9g4/uWPrwP5IWP0TxBDxi/MlmW36Sp0cgycOij
         2JVU870rfT0wnstVKR9QaoFIEwNrTId7aV8YxtFOnDMp1/K8dNUP2rdRH3zuNJ+dUf+3
         8bVOQ137h81VguRjEu/8DlirjkxxI0JNc6ROy+fEoAkQTSXt5u3UUb6wYq+BqEBTgGE8
         8f7TPaB186lZAaTFLPENAIHO3Nlzjckm1JtA5Z9QWPmpwlVTBO5ve/q1FgchYME/0x/q
         27oilwPwikYropjwPHjPS+qJSykW+EroV+TKNxC2ZdUQncpiMAWxTTSfz7xIcxY/LvsR
         +32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693340345; x=1693945145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UUpY2VL3S9CLj7f7/TQ8oC3zq6bYGzeqnah/K/J6KSU=;
        b=IN9RIJ3T+6On07NWlW9kiLb8n6gLU38R1wrlZyK84KkUqUEOG5+DUBnlrLQMTOWHYc
         ZMCL27zJm4ocDXMDQ7QN2PrMRNyZ8eaulBjMitB7ciZfla9O4CKw9K7Fx8yV3DFz/bds
         hohQo0Oekdif9a+Bd0dDUcHps4NSgpplQfN4zIoLwLjEq/STEDn106IRHfHYQWe51VPQ
         2MlEAN/SnfqKKLo9iWhY0L8gZk7TULufTf0Ob42wUik9i+lObaF4ZyX/vFn7fOmHHcMT
         jvclBiNpmBaDVJnzB9/DOgD6FBM0awQVDeQ8bwSKlvkqB6q/1G0HsU/JbHXebIZNjLwk
         Rk3g==
X-Gm-Message-State: AOJu0YxOkIT8tJrR5w+o2YwdjWM6xZvV7+85qBlnMEcBCsWQHaV1h0kY
        7+OMiG4t1ToxfFkOA7kxcGc=
X-Google-Smtp-Source: AGHT+IHTkmbCWexyEyR65EHUpfvptTPuGNTwCgfR5Am1u7aSp9mGnGPh0S7soxktPKAgT8CXykvpyw==
X-Received: by 2002:a6b:e801:0:b0:792:6dd8:a65f with SMTP id f1-20020a6be801000000b007926dd8a65fmr498247ioh.0.1693340344987;
        Tue, 29 Aug 2023 13:19:04 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:b9e5:28ab:6ad7:257e])
        by smtp.gmail.com with ESMTPSA id gk8-20020a0566386a8800b0042b2f0b77aasm3300798jab.95.2023.08.29.13.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 13:19:04 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/3] nfs-utils: gssd support for KRB5_AP_ERR_BAD_INTEGRITY 
Date:   Tue, 29 Aug 2023 16:18:58 -0400
Message-Id: <20230829201902.63036-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

