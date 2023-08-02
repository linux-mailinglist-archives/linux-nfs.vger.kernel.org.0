Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEE776CB29
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Aug 2023 12:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbjHBKoE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Aug 2023 06:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbjHBKnn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Aug 2023 06:43:43 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CBB30E9
        for <linux-nfs@vger.kernel.org>; Wed,  2 Aug 2023 03:41:35 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbef8ad9bbso71518755e9.0
        for <linux-nfs@vger.kernel.org>; Wed, 02 Aug 2023 03:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690972893; x=1691577693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YgNcim2dL7pjjmrHNNKr7SZxjAPH2vynKbx9rcM8Mlw=;
        b=YWplNLg7UPqde5B60m6OlJf5GN/pzFSb0R/iqkm3PB+Aa3UMsWIbRcf1T/qla7arVx
         GQ9twU0WygEmXeQtFkliWx6MNXs7fNpNcQqGnGlMmC6tpgp8+EzJrH1v8gU3Flkl+tdm
         9sayaVbI3FrfxwxpFiWaQX0p/aRVAdhbfS34vwd8iY4O+i+jGGRxXpDR89h07/u1fKkv
         tQuGN4A97NkVLcgKW3yJ3Byfl5QXCh0xw+kzT7ZFo+CsmYnp0jHYJFxTBeMQVbINlq7A
         FL68fC/rQwsdl7YoIwjSklcDptw2lXp22joZ/efQNyQmG4GVqv1hExYeL1shzWkT10VG
         HhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690972893; x=1691577693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgNcim2dL7pjjmrHNNKr7SZxjAPH2vynKbx9rcM8Mlw=;
        b=emIHIldtILoLKHxIAy9UCeYbPECUC6czLrSn9xDIK30JjZmuQsEQ7e3jvy1TjNcTcp
         +J1vDy39e7+kLXnBPpusJ4X9PtSSSrSiWikN5T8ZsrLE/VyRCFKahbFjSfKsE3jFDYUz
         6pjFMIDeZEw9TNdlzXbYBiozAprdRWi/3TYuIRjE/lZsLGNPj8Rp0cMLEM4NjbL7G22B
         LMMPATLB5D1OIV0VYGsgzgWI6PIGBowjFfFq2cYyThRxLhli21ZtoaJGMQ6hsjAUIpwR
         6iHT1OtkGPnauaC1LwCZXauARDBZm2os1Q0BWqp0laR0od0J6DuC0pIVpfcwlDLHV7tE
         MBJQ==
X-Gm-Message-State: ABy/qLbNyi4vCHZ0LzIFKiuP9nHfvzbKXGt6e42Xq0OEC9Dk3c40JTWU
        y3rtJAXk8XlMaPcChCDJo4Z3YA==
X-Google-Smtp-Source: APBJJlFWb9PEPbh90efGD3Dx/+mVuVjkBG6YAYZKDfYBbdL8Q9HknA2mANvJ1hlVkV/DhTtPLlvnsA==
X-Received: by 2002:adf:e792:0:b0:317:69c7:98ad with SMTP id n18-20020adfe792000000b0031769c798admr4622443wrm.3.1690972893500;
        Wed, 02 Aug 2023 03:41:33 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id y1-20020adfd081000000b003179d5aee63sm10531548wrh.91.2023.08.02.03.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 03:41:33 -0700 (PDT)
Date:   Wed, 2 Aug 2023 13:41:30 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        bfields@fieldses.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs: lockd: avoid possible wrong NULL parameter
Message-ID: <0bd584fd-74ac-4b08-ae03-12e329ab186e@kadam.mountain>
References: <20230802080544.3239967-1-suhui@nfschina.com>
 <531df8ee-ba09-49df-8201-4221df5853c6@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <531df8ee-ba09-49df-8201-4221df5853c6@kadam.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There was a big fight about memcpy() in 2010.

https://lwn.net/Articles/416821/

It's sort of related but also sort of different.  My understanding is
that the glibc memcpy() says that memcpy() always does a dereference so
it can delete all the NULL checks which come after.  The linux kernel
uses -fno-delete-null-pointer-checks to turn this behavior off.

regards,
dan carpenter
