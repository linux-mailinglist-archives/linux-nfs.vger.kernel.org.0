Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96477C4CC5
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Oct 2023 10:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjJKIPE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Oct 2023 04:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjJKIPC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Oct 2023 04:15:02 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C059D
        for <linux-nfs@vger.kernel.org>; Wed, 11 Oct 2023 01:15:00 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32d849cc152so374400f8f.1
        for <linux-nfs@vger.kernel.org>; Wed, 11 Oct 2023 01:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697012099; x=1697616899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vtpagy2FOAC+A5GQkeyxkxyJtI+owSgz6W8MfKmR89U=;
        b=pz4t2y1UiskQpLcGhsbTsrF16V7Kyf1HXEd56nBXlVdKfmGiI06BaByidA1HhhokTV
         r8wxkysmhnyCxIdaEgOJtI9AeTp3kR37I99Iqoze9TENa+L4ldSOsaiV8VX9/awiiWJf
         Ms1NuqqrVK1GKVZ5t/tmOqHTV+MZUbyP6Y6pdvJ4BUJ7nCARXiQM4+Ce9ITD17XDKBTj
         cP2mV9h5KFayo9zKGfyQQbmEkK4w4O0sD4O/V2k/FhWGG2s8YfDq3Ciq2qyTAORv2qxB
         1ebmbjGbWpKczc9+nPmiZIWpy6zCoZJtXkW/y/lEFqEaIE1hp46X1+GwFkZ6d03y9X73
         8QYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697012099; x=1697616899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtpagy2FOAC+A5GQkeyxkxyJtI+owSgz6W8MfKmR89U=;
        b=do8xeGUThT2+nhqRV137bh+WJ/2E2TT4fiBKMBeER+kV/bHHws2g7L9g4mqy6lctCD
         wtL1ARb2QEzcPs+NuNdZ7IEj4EfCvwJPrK+4ieq7o43Nr2WBuQ+0D6i4oTZwENgwQtD0
         ydB8d9xA1VR637lAFadOxTLG54jbXRVbdX9wgBe6ITpUi1Sc8QBhCjRP0Q/P8IVla4a/
         bHq1jQOuJajphAPnXbwdN6dzdStqA5ZYo5ZgAdwbUU29K5CU2SGmQ3yVVltGbI48BFGS
         sB2rowl341+tEKotwbM6MtZYf8vULH5pvxvI3B29Bmo+YbzRfOkzi9fR8cZCPP1h8+7+
         sfeA==
X-Gm-Message-State: AOJu0YyKHwUNr/Tx2/mC++h93AJtPa9SIO/fntCUxuP9l14HmxJxm7BF
        Y5Poy4SFO9VK1d1XmEx4v3Wt5A==
X-Google-Smtp-Source: AGHT+IH+nFbUIrVmTEv6gMfTbmCrdI4fJezaJJy9xkJMds1ntqxtbKt+3p2wLJX84bwnz9RfZSqaUg==
X-Received: by 2002:adf:f641:0:b0:31f:b6ea:af48 with SMTP id x1-20020adff641000000b0031fb6eaaf48mr17486391wrp.49.1697012098954;
        Wed, 11 Oct 2023 01:14:58 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v6-20020adff686000000b0031980294e9fsm14561839wrp.116.2023.10.11.01.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 01:14:57 -0700 (PDT)
Date:   Wed, 11 Oct 2023 11:14:55 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Xin Tan <tanxin.ctf@gmail.com>, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-XXX] SUNRPC: Add an IS_ERR() check back to where it
 was
Message-ID: <38b1b94c-3ab1-4fb5-ad8c-946756262bdb@kadam.mountain>
References: <356fb42c-9cf1-45cd-9233-ac845c507fb7@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <356fb42c-9cf1-45cd-9233-ac845c507fb7@moroto.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Obviously net-XXX is not what I intended.  This applies to the nfs tree
I think.

regards,
dan carpenter

