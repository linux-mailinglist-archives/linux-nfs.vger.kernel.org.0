Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A790D71A343
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Jun 2023 17:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbjFAPwZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Jun 2023 11:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbjFAPwI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Jun 2023 11:52:08 -0400
X-Greylist: delayed 4695 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Jun 2023 08:52:06 PDT
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d501])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6C513D
        for <linux-nfs@vger.kernel.org>; Thu,  1 Jun 2023 08:52:06 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:440b:0:640:fa3a:0])
        by forward501b.mail.yandex.net (Yandex) with ESMTP id 715E05EB6F;
        Thu,  1 Jun 2023 18:52:04 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 3qQBLu1WluQ0-OlnfqZbP;
        Thu, 01 Jun 2023 18:52:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1685634723;
        bh=uswP63JQZujF2jamGzkaUVVDxcK18yUIda6WAhbD2ak=;
        h=Subject:From:In-Reply-To:Cc:Date:References:To:Message-ID;
        b=HE6+b50Sieo2EaOslLRo0VLthgVNkuqrrD5T7kfwLeG5sli1B6swN2n989tfyEg8E
         rrWkaEZxNYF4zbGy47DokoU/IVAAZGFBbUzWAiUihj0kF4ag2AE/iWQF0YYJzYQzZi
         oWwrJdyuB7ADJOBRIs8vGnNsJJW4P4EEo1xFkHBs=
Authentication-Results: mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <ed2f956d-632a-90e1-f2e9-91710be5f2de@yandex.ru>
Date:   Thu, 1 Jun 2023 18:52:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>, Tom Rix <trix@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20230601143332.255312-1-dmantipov@yandex.ru>
 <2D3D2D8E-4E7A-4B50-A1FF-486D7F6C26D4@oracle.com>
 <8ed6eb2b-fdfa-4fde-81f3-92e6b34bc509@kadam.mountain>
From:   Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH] sunrpc: fix clang-17 warning
In-Reply-To: <8ed6eb2b-fdfa-4fde-81f3-92e6b34bc509@kadam.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 6/1/23 18:34, Dan Carpenter wrote:

> This is a bug in Clang.

Is it confirmed by LLVM/clang developers? The compiler says that
<any unsigned 32-bit> can't be larger than <max unsigned 64-bit> / 8
(assuming LP64). Why this is wrong?

Dmitry

