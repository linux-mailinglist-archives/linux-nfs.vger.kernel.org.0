Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC6D7D9366
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Oct 2023 11:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjJ0JUh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Oct 2023 05:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjJ0JUg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Oct 2023 05:20:36 -0400
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E49C0
        for <linux-nfs@vger.kernel.org>; Fri, 27 Oct 2023 02:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1698398429;
        bh=FGwyJmx88ElAYWqHpOihsHWE/4m3vOJOJL+g4l6mZOI=;
        h=From:To:Cc:Subject:Date;
        b=c9UQqkbB5cIPWbTTFfgoS2VZtRyiZpToh1zyCGd1aXckCXFNsjtt4hhE9C7RDoT/Q
         qG8O9dIZXgtnozybNMNLaDzOo2BItilr6TNCk/2E291cQSWhsJACAzxGZmCcFDl53k
         Eoog5D4mve5DPjgdP53auSBX5XZOY1uAv+GVyRqM=
Received: from linux-lab.localdomain ([202.201.11.22])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id 4EA14ABB; Fri, 27 Oct 2023 17:19:42 +0800
X-QQ-mid: xmsmtpt1698398382to9n9dan5
Message-ID: <tencent_51EEC8890D6DB3A4370173F4B28839F41505@qq.com>
X-QQ-XMAILINFO: MW5hkHoBpWXyN1T7Ml7xDijEmGyoynBYDD8OzkrwA/0U02WevA9tEdSVGMKoei
         0csvu4T+UMM8Rw3HtSnn+9Z67UN8EeT0jr+CtUvzXguw8O2G7JjKXpMqkZKnKp4w5TVrpCWPLwLf
         ukOUqofD4e5PzqgzsZg/S4aQDPN0v51icwEQU/dcFfEZ2cyI3ioZbHT6fvQ40ncxHEqRn2t4kOdx
         75eDU3ZxcCaVkWiTwrjzntG6eSBdFI7+Y3M6D1QVVZkedSDCcn2qJ1UDxX89dbS5pHmuDKOyyfnf
         E2oWx5gp5PDoWWg/SGAJplZWIejth3Dx4I/POrWgPht5qgsE4GUjJvzVQGN3YacagCZSId8s5Cqo
         4wYTtDUznXT9oyR4nj+6U4zZ6szuxz28GQP/XeTdk4nldiYhl9CcSweLnssGY4N6fG7S3uDhbOnV
         4MvLYEgAOOBQja3rcdWxYGCoiu7rcSM4K5g76Q3qIfaGm/R6mbl4Tz3glU67BeqFibq4UlcUDr7L
         tS+zgL45p63xnN9RuWZD2LNErs+9bKKVnEvnFzYbxq7qMpzJTT4SOrnUH2QEsrFO6R15skyCZHAO
         YR7EGCZGWvKf/NlqgE5g10+2HesI0/iQhn4D22JedVf2eoD9Fm+uOyt4Wd/a6lYong0COWsjdH8q
         IluV0ern1OoVWNPw6d3vUF/TiVMHFi/PZZ4lcg4fMqZhPO+FKuEvMu8NHTGlvvF88koeR9fY8sdo
         WIt0Yj9TVD2aUe9pEcqQC2A9seHQyN4FaAgYjQHGCbi5giMXeR6fGabQhoyubDHpmJ/Gz9YVgqR2
         bxCOenVjMUkTXPV9l0NA+7R9bM/lZZQ2KXtkHVKAsZl9aBQ20eg/s9CwR9ae2TXLMqxiji5qm5Bd
         HZYD7RXVZLyAfhORgb98iCSLKQFs0/0EJmvkjMLzlWYReNm9N3KYs55uzevIrfQ+kyc0H1asuPoJ
         op6hd1s3Ntq2QQaBHiv2yUrFdOc3fSpFqSR3bHX2/jcczEREV4UjYzj+weDba7
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From:   Zhuohao Bai <zhuohao_bai@foxmail.com>
To:     baizhh21@lzu.edu.cn
Cc:     falcon@tinylab.org, forrestniu@foxmail.com,
        libtirpc-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        steved@redhat.com, tanyuan@tinylab.org, zhuohao_bai@foxmail.com
Subject: Re: [RFC PATCH] _rpc_dtablesize: Decrease the value of size.
Date:   Fri, 27 Oct 2023 17:19:41 +0800
X-OQ-MSGID: <20231027091941.660-1-zhuohao_bai@foxmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 26 Oct 2023, at 09:08, Benjamin Coddington wrote:

> This is addressed by several users of rpc_dtablesize() already, which all=
>  seem to do:
> 
>     setsize = _rpc_dtablesize();
>     if (setsize > FD_SETSIZE)
>         setsize = FD_SETSIZE;
> 
> Does it make sense to try to fix it for everyone, and should we clean up the users?

I apologize for not realizing that some users have addressed this issue beforehand. Nonetheless, I think it is necessary to modify the _rpc_dtablesize() function. I suggest modifying the _rpc_dtablesize() function.

        if (size == 0) {
                size = sysconf(_SC_OPEN_MAX);
                if (size > FD_SETSIZE)
                        size = FD_SETSIZE;
        }

In the meantime we need to clean up the existing user code.

