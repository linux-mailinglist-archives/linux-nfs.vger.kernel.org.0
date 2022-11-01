Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400A3615163
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Nov 2022 19:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiKASSG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Nov 2022 14:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiKASSE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Nov 2022 14:18:04 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561091C409
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 11:18:03 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id a67so22933108edf.12
        for <linux-nfs@vger.kernel.org>; Tue, 01 Nov 2022 11:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cw7HVE1SPu6R3gKlfGmuO+9m2wrl2ok1K2iKevUfi5Y=;
        b=ht+YwAkcwRJXxz86OmCFiFmjrWwR385z8CAEd603+eEA5T8CXDxYD79B//DgR8KOg8
         MtpK00QlAcjjXL3WlQ6Tnatj/4PbH5CHXryXiOV7TyDTeFwBg8bL182/rjqej2Xua8e7
         2A8rlK5CENlTTgxsVsoVV8Xn5ZqJw29sJgHV4RWt5TX8ZPqAl5/uNsE/jvCTbmRfCIHP
         lyHHwBRaxTMfo6obHR/XALM5rdPoLdxNaNqmcHnNj1IZzMKXtfIyvuO2QZ5eaaxErThc
         LuKXDWHGri4yQyQucI/rfYhoywhQ0pTZMjTgQW1y4+W6ehrNJWVtzaUO9PsG5A/QgqXq
         7SyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cw7HVE1SPu6R3gKlfGmuO+9m2wrl2ok1K2iKevUfi5Y=;
        b=DkcdT17Vq0fVqtpQhkNFJH3DE3ef506gK55qZ+s6b5YCbldLGxgVt5kHYM3dEXwz/O
         3482UhP4fTUHjvKzejl3zdnenaV0vto9+C2FdWI/MZEIuLd32/NumeuDjmQw8tHUZ/PL
         hMt4yceJX0hniBfs4dQp76vKKB+lRb+mj+6v+zbW6/+8NA9QrrgImqKgyCqSSj5Wfhuj
         YWw1IjKSTNPjVur5uejn1yXZAAXuDow5M4vyopx9OqdrGj3hwbbv32KS62gumytp4qrs
         Gh8dcvJz18n7JxXLusCcawPFa8oDB2vpnbl4xMStThhl7YYmjO3rF73O0FY7QFlSF6Ma
         9d2w==
X-Gm-Message-State: ACrzQf27XvAO0uA5F4Vqt+Lfuokh05eSpqGbm60X1NQWosZ5YaKnjjnM
        M6TmR6Bhh5Fj8wNQmhK22Aqu59mSGxQrr2/OPxQ=
X-Google-Smtp-Source: AMsMyM6vcj02fgjExjSSBvRvbiIz0uGyk9ZqY93FYe8WI/m+NBEUAtVuw9zQx1eWkuupcReEU/vEO/86fnbk7xbU8yI=
X-Received: by 2002:a50:fb95:0:b0:463:526:308b with SMTP id
 e21-20020a50fb95000000b004630526308bmr18252177edq.424.1667326681780; Tue, 01
 Nov 2022 11:18:01 -0700 (PDT)
MIME-Version: 1.0
Sender: bekeitive5@gmail.com
Received: by 2002:a50:3943:0:b0:1e5:366d:c45b with HTTP; Tue, 1 Nov 2022
 11:18:01 -0700 (PDT)
From:   Attorney John <jer.91244914@gmail.com>
Date:   Tue, 1 Nov 2022 18:18:01 +0000
X-Google-Sender-Auth: cRN2ppxxCgX0PXoCIpr9i0Kss14
Message-ID: <CADjmEWPHWh_tCoLpwdiNJaQQdqSYVuYY_HyAGeg27ARQ9PB0cw@mail.gmail.com>
Subject: Very urgent.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Greetings!!
Did you receive my previous email?
Regards,
John Kumor.
