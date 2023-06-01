Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8D571EF42
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Jun 2023 18:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjFAQkL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Jun 2023 12:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjFAQjo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Jun 2023 12:39:44 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD11A1AD
        for <linux-nfs@vger.kernel.org>; Thu,  1 Jun 2023 09:39:33 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f4d80bac38so1383190e87.2
        for <linux-nfs@vger.kernel.org>; Thu, 01 Jun 2023 09:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685637572; x=1688229572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1B+5bULKgfMbaSUBt/TWBqevF9cJ91jN01pB/3V2OJk=;
        b=rVNHwfT8zXDu87gweC/088wGU/51h47p14+T225YhjTus8yk+o4//83zvzm1KXbCAi
         KQznxpJOSI/VqECXwKafQQoFAnQWAAC0QypS/c2QXGsJWq/orB3KWg/pd/LSx3oLb3aX
         LbIQDpLmhbIRfAqtWHQlqe2tGwDlhc3AofzexdeUinyyCMQMeQ110B2bys4SS9ZGXqff
         MN2e0xktAfYsgrdffxFclGwyfh0LTcrkCZrkerQpJslgfsrGayAnBSrQaBtWvbGGRETz
         5s6xF5LS4sSB6XNeH6zB/s6LcytUCpj9aQbDgzolP9EWi8kivtlejQLUMcLT1bmDynDJ
         MmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685637572; x=1688229572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1B+5bULKgfMbaSUBt/TWBqevF9cJ91jN01pB/3V2OJk=;
        b=CsgEwy06QUPE6G4Bk1ZBDHMRFpfRBDJjxL6U5Pqz5gRacX/4CPLKkVc3cXq0EA3sWL
         Aov7f329Udn+N9dRjo2aQXUk4mZ47KS3E1zW2kByZHpMs0360647b6Km0FBuX0g6suCg
         sNmUuf05OKHziyKSiUi2UkDdTisXr0y/sEcYLwdIv+a46qa3++04ID3CYXExB0jV1zwR
         d6zIVt7mdLuu20cA6fZxT/BNoJYa0AY1RoHOeogevo3YA20383gI4bgWfjni+nLBN1HP
         qyw/5DRUVGAWD7GXW7OZQYAI+CHClAX5a2c1M+fDxsskrvtecpugw1tvIqtnDzjWipaL
         1TUQ==
X-Gm-Message-State: AC+VfDxWkhCrKrDEeZBagYCBiRd+vM7F9kbKY1gSWzlsjIkJX72mNxXh
        LyzkqxMaEZdTKbyRt5jQ9WxbIA==
X-Google-Smtp-Source: ACHHUZ6Cd2vWWQMA2v2P9oZ8OCtkfjy015swFB6bNKd+PlvIFwv0K6ao6NsQT3JdKFw6G+TA0gp7oA==
X-Received: by 2002:ac2:5a50:0:b0:4ec:9ef9:e3d with SMTP id r16-20020ac25a50000000b004ec9ef90e3dmr354668lfn.26.1685637571868;
        Thu, 01 Jun 2023 09:39:31 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id y13-20020a1c4b0d000000b003f3e50eb606sm2879993wma.13.2023.06.01.09.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 09:39:29 -0700 (PDT)
Date:   Thu, 1 Jun 2023 19:39:26 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Tom Rix <trix@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] sunrpc: fix clang-17 warning
Message-ID: <c6c5c38b-f258-4dda-8227-5f672b37bc77@kadam.mountain>
References: <20230601143332.255312-1-dmantipov@yandex.ru>
 <2D3D2D8E-4E7A-4B50-A1FF-486D7F6C26D4@oracle.com>
 <8ed6eb2b-fdfa-4fde-81f3-92e6b34bc509@kadam.mountain>
 <ed2f956d-632a-90e1-f2e9-91710be5f2de@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed2f956d-632a-90e1-f2e9-91710be5f2de@yandex.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 01, 2023 at 06:52:03PM +0300, Dmitry Antipov wrote:
> On 6/1/23 18:34, Dan Carpenter wrote:
> 
> > This is a bug in Clang.
> 
> Is it confirmed by LLVM/clang developers? The compiler says that
> <any unsigned 32-bit> can't be larger than <max unsigned 64-bit> / 8
> (assuming LP64). Why this is wrong?

It's a false positive because the test is obviously intended for 32-bit
longs.

regards,
dan carpenter

