Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8914D71A2E2
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Jun 2023 17:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbjFAPmx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Jun 2023 11:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjFAPmw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Jun 2023 11:42:52 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D032CE2
        for <linux-nfs@vger.kernel.org>; Thu,  1 Jun 2023 08:42:50 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-30aa1eb95a0so1072213f8f.1
        for <linux-nfs@vger.kernel.org>; Thu, 01 Jun 2023 08:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685634169; x=1688226169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fS6tSgla5eJmil0MyVXfnS4M7PGBmQgtmNIt23TIYNg=;
        b=BuNsAMEZtebZeX2z0Z9dvND8X27LHDCpW8JIQSupRqJFJICUWPEXRugBC4UTlvnCzA
         /yYDQrgfxYZ6r6IVyg2fE2oFdh1BJG5Xd3H7q5FfELsf509SiRDZ+qPt0twKTGBu8uKj
         iR6AWT1l0A3D1njqcEPTFa4vQ60JHDeXEaXQdbQNnSjG6C64On+JqRQQ7P5kjru+TkDG
         tGzL94I0S4QAMhATLpSj+u1fSUhMVofOLJm3OquOLTQrTKfaWgLZQui7/NYPtEvwAt3F
         6koIrNPbWTy2IN+xfzKE3BBxyXXfn59CPkJCsz9g+ipvgVD/+Lefg86IF7RxttMH7n2R
         5I1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685634169; x=1688226169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fS6tSgla5eJmil0MyVXfnS4M7PGBmQgtmNIt23TIYNg=;
        b=lLI6x9bR1CQQ2wXzWk/NN+F0463jN08jPbHIBNUz5WqUe675SJaa5dSArm2xo+agii
         hClSQcCz5o1fWPCe6Y/XYnysVtgUcrqKLFHjpDjg5chb9gIKenY3quK6ruKW7w1o1NXM
         z+biclPYnOEX+tnqsI2RB21DR2gD9dc+W/C4RK8L9LaqinWxP32aZDlyS8ygcjwxEjeS
         IFzoWJbtm6Q5BFkJw6DPp5bfdQPpfurWrrE0K5NtRBOZlvBpQ+L4N2T47pmxrOlRk4i6
         5xccIGoNm2LkHkjMqDpIhP8ZaoL3ep1KDQBr9KwQfr8adw8Hi6Ab9d2B0LeMAf7g/618
         QZ+g==
X-Gm-Message-State: AC+VfDxVoA0i5Tejbvh/+/8Im39oye7dtCZ2yqKYjRWxJZDgl27ce6D8
        cv4ap+zy5P+lp7MlYiA4UNsAow==
X-Google-Smtp-Source: ACHHUZ6ic761J62W8mppY7R7Whor3WiDrnR8ilUorR8v6OqS9ZFWr+EAdYSRQYYTUchi0e++ZOmeGQ==
X-Received: by 2002:a05:6000:36c:b0:30a:de3e:9674 with SMTP id f12-20020a056000036c00b0030ade3e9674mr2199053wrf.57.1685634169263;
        Thu, 01 Jun 2023 08:42:49 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id bf3-20020a0560001cc300b00307b5376b2csm10617518wrb.90.2023.06.01.08.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 08:42:46 -0700 (PDT)
Date:   Thu, 1 Jun 2023 18:42:44 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Dmitry Antipov <dmantipov@yandex.ru>,
        Jeff Layton <jlayton@kernel.org>, Tom Rix <trix@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] sunrpc: fix clang-17 warning
Message-ID: <7ce61658-3a22-461a-a986-57b767f9e25f@kadam.mountain>
References: <20230601143332.255312-1-dmantipov@yandex.ru>
 <2D3D2D8E-4E7A-4B50-A1FF-486D7F6C26D4@oracle.com>
 <8ed6eb2b-fdfa-4fde-81f3-92e6b34bc509@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ed6eb2b-fdfa-4fde-81f3-92e6b34bc509@kadam.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I'd kind of like to make some other changes as well like...

I think I looked at this and it wraps to zero which is harmless but I
just hate that it has an integer overflow at all.  Gotta run though.
Will look at this tomorrow.

regards,
dan carpenter

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index f89ec4b5ea16..3550dea95420 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -29,7 +29,7 @@ struct rpc_rqst;
 /*
  * Buffer adjustment
  */
-#define XDR_QUADLEN(l)		(((l) + 3) >> 2)
+#define XDR_QUADLEN(l)		(size_add(l, 3) >> 2)
 
 /*
  * Generic opaque `network object.'
