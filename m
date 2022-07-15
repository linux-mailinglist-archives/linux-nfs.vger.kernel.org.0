Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0494C576A53
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Jul 2022 01:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiGOXCd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Jul 2022 19:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiGOXCb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Jul 2022 19:02:31 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC1D52FDD;
        Fri, 15 Jul 2022 16:02:31 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r2so7597538wrs.3;
        Fri, 15 Jul 2022 16:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Zp1wz8ktnqwrp1kQodkRzKqSEOkCnt8EN3Ge4kgtjYU=;
        b=koIFTa3nhw9SEtIcvlfo024ecfKnplunCKTuJyP18SS2Ds/fAhI9biGIrq945YvhOq
         ecFVHY5KsyxJjKpLDCilNNOugN4G5wiSHkJmilcDqR7CYAM1Ip0mqMkM/Ndbw31rD84W
         G4eoHYOCv1qPQxMY6KasT6V1DIeg1IUXQJPDTqC0PVXlphLqEnD0YysFmS2/jnV/2pn2
         nfPJqYvDqotsM56/Ro+Tsqy+NiB/gc72hBv/kqplcYZWLpb2zLCz1i6QoBQgq89BYTdP
         NINQZu3xO4mN+cuHTqFRhc1OjdZmGRbrmIFoYyqkxP/LTRbdIoNNazthV5YeHoqqkNXW
         n7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Zp1wz8ktnqwrp1kQodkRzKqSEOkCnt8EN3Ge4kgtjYU=;
        b=6+nwqZrmLGIi1phJg1BwCzF2JguhPZbNlpQWQQELTi89ZUFqOQ1VFT4cAAUPLmYfTZ
         vAKIJzixfonm0Qd0SNawUbixHieGINZx5IMthFtxw0n3swWO/kDoa52kV4QEUDchvbsB
         1dsGoqnDgwCNYigvKyMKGzfsYp9acC9N+skNVbZ75DQvLPRKdB3R6pUBdoQY5kLR40T3
         e/pNqbuN7Xu3z5uAaWLEk5NszuGMh7iCWnv2mRXQiBeOyoI2tSmViEjzBlHrPgkHLs83
         DNtZxiB1rNGklaNCP/Q8Hc6j82IeyUh73p5C6uMypCDP1Ysj/545uUs3ypnBoTyzA/QE
         SFkA==
X-Gm-Message-State: AJIora/LgUIBqPzs2ngMxs0zFvmrvClO43zAD/VsKR9VRuKljWjpVVeO
        pJ8BCj2Wqy2yOYiPIHB0ZFcg+6vFa2I=
X-Google-Smtp-Source: AGRyM1t/82iPkc9ko/SCfg1+O/Cpdvzze0fH+xqsaUSpyyLWevMJOoLQBfUPgHfZ82RQvin1fMejLw==
X-Received: by 2002:a05:6000:2ab:b0:21d:b410:5777 with SMTP id l11-20020a05600002ab00b0021db4105777mr13722853wry.569.1657926149591;
        Fri, 15 Jul 2022 16:02:29 -0700 (PDT)
Received: from debian (host-78-150-47-22.as13285.net. [78.150.47.22])
        by smtp.gmail.com with ESMTPSA id l14-20020adff48e000000b0021d7ad6b9fdsm4736076wro.57.2022.07.15.16.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 16:02:29 -0700 (PDT)
Date:   Sat, 16 Jul 2022 00:02:27 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Dai Ngo <dai.ngo@oracle.com>, Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: build failure of next-20220715 due to undeclared identifier
 'NFS4_CLIENTS_PER_GB'
Message-ID: <YtHyA8TL8ObXJ6EQ@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi All,

Not sure if it has been reported, multiple configs of arm and mips have
failed to build next-20220715 with the error:

fs/nfsd/nfsctl.c:1504:17: error: use of undeclared identifier 'NFS4_CLIENTS_PER_GB'
        max_clients *= NFS4_CLIENTS_PER_GB;
                       ^
fs/nfsd/nfsctl.c:1505:49: error: use of undeclared identifier 'NFS4_CLIENTS_PER_GB'
        nn->nfs4_max_clients = max_t(int, max_clients, NFS4_CLIENTS_PER_GB);
                                                       ^
fs/nfsd/nfsctl.c:1505:49: error: use of undeclared identifier 'NFS4_CLIENTS_PER_GB'


--
Regards
Sudip
