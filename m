Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6535E6ECF
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Sep 2022 23:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbiIVVtd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Sep 2022 17:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbiIVVtb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Sep 2022 17:49:31 -0400
X-Greylist: delayed 183 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Sep 2022 14:49:26 PDT
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA42F508E
        for <linux-nfs@vger.kernel.org>; Thu, 22 Sep 2022 14:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1663883181;
    s=strato-dkim-0002; d=garloff.de;
    h=Subject:From:To:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=xBs2Wqix5DTO3DjmgN94fEWRrRa4QOlA7u9cTAYpEeE=;
    b=epeRw0okNqybxdsxvCV3+3I25VZOFtutR6KhNbLflr9nAJrISIYWgBioDYpTUBniei
    di3SLv/DUM2VkilO3U/EHTOGU+TH5UXPED+9/tb2TCCsZCFh7EjldpTs6SF8K74A9cSh
    9eNvlslPC/O5/yVIwm6db1iSe0HbtMX9m15MDAJLAGPocYc8nZeXGYe+/SWte5NCDG6l
    LjP0Oc9QBX8RzsNWXNNGNsN8alw+Q/f0i+iuls5BH3C73Qcxq8je/X7TjQRWM/Wuy01J
    0q8IzejZOjNfDGiTRh7KFsEanyEKdztFTeHqjqtS11OXlBZuwaEF61gjKGrqqSc0gxRr
    IGxg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":J3kWYWCveu3U88BfwGxYwcN+YZ41GOdzTdHQ+J8VEEsqY6Ge7bJ1uNpe7Q=="
X-RZG-CLASS-ID: mo00
Received: from nas2.garloff.de
    by smtp.strato.de (RZmta 48.1.1 DYNA|AUTH)
    with ESMTPSA id Vd953dy8MLkLn5Z
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate)
    for <linux-nfs@vger.kernel.org>;
    Thu, 22 Sep 2022 23:46:21 +0200 (CEST)
Received: from [192.168.155.202] (unknown [192.168.155.10])
        by nas2.garloff.de (Postfix) with ESMTPSA id 6F1DEB3B0054
        for <linux-nfs@vger.kernel.org>; Thu, 22 Sep 2022 23:45:23 +0200 (CEST)
Message-ID: <f6755107-b62c-a388-0ab5-0a6633bf9082@garloff.de>
Date:   Thu, 22 Sep 2022 23:46:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Language: en-US
From:   Kurt Garloff <kurt@garloff.de>
Subject: linux-5.15.69 breaks nfs client
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

a freshly compiled 5.15.69 kernel showed hangs with NFS.
Typically mkdir would end up in a 'D' process state, but I
have seen ls -l hanging as well.
Server is kernel NFS 5.15.69.

After reverting the last three NFS related commits,
a68a734b19af NFS: Fix WARN_ON due to unionization of nfs_inode.nrequests
3b97deb4abf5 NFS: Fix another fsync() issue after a server reboot
31b992b3c39b NFS: Save some space in the inode

things work normally again.

As you can see, I suspected 31b992b3c39b ...

I know this report is light on details; if nothing like this has been
reported yet, let me know and I'll try to find some time to investigate
further.

PS: Please keep me on Cc, I'm not subscribed to linux-nfs.

Best,

-- 
Kurt Garloff <kurt@garloff.de>
Cologne, Germany

