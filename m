Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489A87D9442
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Oct 2023 11:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjJ0JxN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Oct 2023 05:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjJ0JxM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Oct 2023 05:53:12 -0400
X-Greylist: delayed 149267 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 Oct 2023 02:53:10 PDT
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065F09D
        for <linux-nfs@vger.kernel.org>; Fri, 27 Oct 2023 02:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1698400387;
        bh=KP/ue/zxu8l7wKtLGFLyLI7UO4BUey4BbBnzJT80+vs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=xL68uEwgIEZcFCGWE8nMXqI8GXN3hPftOqENJoJEQR9dNhFN0C4IrVLBlYB0PHjwQ
         l13FB9TAnmn6kfMqh5pAwjmQH5UlMuhccTKGaBWE+f4chgJ86fjaiGx4INw9v2ZUYZ
         4NmYf3L+6WoBADsSBb2u+2Nrqp/C+oPJpYGcMlTU=
Received: from linux-lab.localdomain ([202.201.11.22])
        by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
        id BA633296; Fri, 27 Oct 2023 17:46:38 +0800
X-QQ-mid: xmsmtpt1698399998t46rr57vr
Message-ID: <tencent_096F0EE6FFE508B3DA2BF89110DBC7E65506@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+SiqTGR/e8p8tykWVyihnA8OaFZlZpXiVRYMA3VnMk30xzFhOCM
         6xAxHgTi/MbBiRQxQqSqZpKj8gxK57kcLp+p1yAOhZD76Q5m+aBsjIQ4YbN1QS2DsDspex7Cotps
         9N+b7qkR0D8bKwgQO2X4G2aYq74JxJVK9+et7r5n4vaFjd3xX/bjDq4yh1NgLl/hzc8tZBNY5780
         llo6Ac5ef7cJiNDdt1f9VCvDmYJHtjwmD/ozAoH9fFckLcMQX5Ez0sktkx7Eb4u91VSzX2M4hGT9
         PFz/jsfjMZXze13x3E4F6hFjrt8gW9nx6ds4pynWaUbB6zsC2Ah3WehXbAFPxNwq1yRFx5EI5Yo6
         2TJziwqijA3ZPFMqI/52qIFST5TsbQPv7gAmy+jfZ0JRvS85YCww/Dw8FsEfhwQ78p79NXQ4Lg5W
         E3O+Yano3LHiWP2m7HBKRpc5kdopAfqQ7Ddrx7W44KhiguaK0q7HXhZY7eBC+K9ixTd81KTRkx/l
         LOgrpyjzqNILXB0oGeBkDWzfocgD5W+kSHOW3sW+P+stEkdIGE0UgIlV061BkUGbdGhgtjWfMnug
         hgpBWnhLQVScn+7sZAWwxMn3Wd/IsZANTvll8xLO7sa4gwSD5LLe9BHIESsYqr9/0Ufve5KXypvw
         l/09QAswxQ1wyYg7ih+jecSf+3Eg5mGwfjZ9yMJyDRhzqSIr/BGahUfDkLyG9JD8J0hm/CUNvdNy
         lQ2mO6DXZ5RtP2+sRru5PEzFJ0dhXRRbC0n/43F9Fd9KUBVNhJ4l9xqHNRNZ6vFsXZqQJHSCC7SZ
         8N2gAuHj9hso+K88hFFFi5Y/Y2iiuHwYSZ24ez65jlr+PJIQ4QBRfIODh8Kxerrjs9TipdGm+P+H
         Zm4i5rRDLhKuKE5T2F4t1r46H5/yLbvHrdd862yINtr/tXL1Fjz3gycgISkIWJFIYG45yZWJrN2C
         Vx2s83DrhIfXHgeF4ov4GT1bQbchROVMBOuikuhc5fVyOVdjOcaFatPngHchw29tzKlr0FaAXKic
         N22oBKPBJgMXee4dH1voMBH5iManIXwpGwy/QZHYnNiz8M7zFvXaBlNk3afYY=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From:   Zhuohao Bai <zhuohao_bai@foxmail.com>
To:     bcodding@redhat.com
Cc:     baizhh21@lzu.edu.cn, falcon@tinylab.org, forrestniu@foxmail.com,
        libtirpc-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        steved@redhat.com, tanyuan@tinylab.org, zhuohao_bai@foxmail.com
Subject: Re: [RFC PATCH] _rpc_dtablesize: Decrease the value of size.
Date:   Fri, 27 Oct 2023 17:46:38 +0800
X-OQ-MSGID: <20231027094638.763-1-zhuohao_bai@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <EAA0AA43-7CAA-4D74-9DD0-4CC738D71D47@redhat.com>
References: <EAA0AA43-7CAA-4D74-9DD0-4CC738D71D47@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 26 Oct 2023, at 09:08, Benjamin Coddington wrote:

> This issue has already been addressed by several users of rpc_dtablesize(), and they typically follow this pattern:
>
>     setsize = _rpc_dtablesize();
>     if (setsize > FD_SETSIZE)
>         setsize = FD_SETSIZE;
>
> Does it make sense to attempt a universal fix, and should we consider streamlining this approach for all users?

I apologize for not initially recognizing that some users have already dealt with this issue. Nevertheless, I believe it's essential to modify the _rpc_dtablesize() function as follows:

        if (size == 0) {
                size = sysconf(_SC_OPEN_MAX);
                if (size > FD_SETSIZE)
                        size = FD_SETSIZE;
        }

I will work on cleaning up the existing code in the next version.

