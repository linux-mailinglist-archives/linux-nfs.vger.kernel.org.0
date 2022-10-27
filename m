Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83EF61000C
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Oct 2022 20:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbiJ0SRD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Oct 2022 14:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbiJ0SQx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Oct 2022 14:16:53 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B743823BE4
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 11:16:51 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id b18so4674224ljr.13
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 11:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KaICaYZQdnRijpM/9PqpZiJSPOBKMyX46adYedTum6Q=;
        b=d4xslT+NHEdUccpXNRlpWh/L6/99OtIEOL5A6LzmykEymPBPv5swT1mXsSYkqwMdqd
         9ET77keTi7HbZG4R5BacNXhdoLp9c9pCBsfIltAPOh3GLConDaXtHeghmRua9pB9jy79
         0gxQgHFvCteL9Rkaq7jwmaGN56qrR9a38GUbojaIgvnk6KcUcUxNfzMhevIquBQJrfhH
         kIgaQPV85nXbkhewV+f+86MHY9GXAPevlxx3VklKQHcaWbwv0TusLU5qM8vGQtZV6hlq
         cHaRiuO+tVfmHkqK8kuEeUH7wahspE1JiNaVeKAWWGfcy8OUZF9W0gt2FF7nOD1dvkde
         7+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KaICaYZQdnRijpM/9PqpZiJSPOBKMyX46adYedTum6Q=;
        b=e9cyR0o292cijKB0k5q5Dc1XeYUhwOMlOLgRWNzXbk5vApaiYwxE7Sz5oZOLoKobyR
         6Njx4JKtVhYJR81dAcLi9m8+PwD9A7wmaPNakcnvwNNRsDgmoUGAOsnoRVJXtqmqhZlZ
         DDoJl/41NzhRrcHsH711c1uLYfrzb66ktD4XwnjqCcjC16mbUBpv0GuQLBbPseHqsuHR
         L8VXaM2MMwXVZP5RTN1Y2rJ8WjKeUgCmdsQhO6COo+oSyjjS21VPESK0Rc1kwitAdV5a
         Zz5OoQ8VKbFBVNqk/dhKy33HygqHOwdpCvpnZwNRP4C9P06T4rWj6HQ++TGumejglaDg
         KvyA==
X-Gm-Message-State: ACrzQf3KYoStO6TZvpOI3D/7OxnBThjm0COuD6SeZXgxYIrleGthIRGP
        ApmTUJtT8rP2NwXAdUEOPSxLVFKxO9JkLnKXN2BLgUvpjmQ=
X-Google-Smtp-Source: AMsMyM5BixVGvUSV7pVmVQvIvAbQ3g+WrEootWYILUdBaFdNJ0VF5niRNFAUvKvp0lj7F/mcCmmGzM0XE3XJCLqlEzU=
X-Received: by 2002:a2e:8758:0:b0:26e:2dab:d4d2 with SMTP id
 q24-20020a2e8758000000b0026e2dabd4d2mr20329333ljj.297.1666894609838; Thu, 27
 Oct 2022 11:16:49 -0700 (PDT)
MIME-Version: 1.0
From:   Jan Kasiak <j.kasiak@gmail.com>
Date:   Thu, 27 Oct 2022 14:16:36 -0400
Message-ID: <CAD15GZfmZYKmGs7GfaUwM1V65uLirgwYBwrvBj7VrUpmFUjOTQ@mail.gmail.com>
Subject: NFS 4 GPF while processing compound with multiple reads
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all,

While writing my own NFS client, I have found a simple test case that
triggers a general protection fault on the NFS server.

The NFS 4 compound is: PUT_FH, READ, READ
The second read causes the fault.

More information, including how to reproduce the bug is available in
the bug tracker: https://bugzilla.linux-nfs.org/show_bug.cgi?id=402

Thank You,
-Jan
