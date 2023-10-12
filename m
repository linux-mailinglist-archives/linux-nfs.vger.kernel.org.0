Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD157C6868
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Oct 2023 10:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347254AbjJLIDe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Thu, 12 Oct 2023 04:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347243AbjJLIDc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Oct 2023 04:03:32 -0400
X-Greylist: delayed 1181 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 Oct 2023 01:03:27 PDT
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C9290;
        Thu, 12 Oct 2023 01:03:27 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4S5hBk5V4Sz9yrH2;
        Thu, 12 Oct 2023 15:30:54 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwBnwJGGoydlzkoQAg--.30762S2;
        Thu, 12 Oct 2023 08:43:16 +0100 (CET)
Message-ID: <80e4a1ea172edb2d4d441b70dcd93bfa1654a5b7.camel@huaweicloud.com>
Subject: Re: [PATCH v3 12/25] security: Introduce inode_post_setattr hook
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
        neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com,
        tom@talpey.com, dmitry.kasatkin@gmail.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, dhowells@redhat.com,
        jarkko@kernel.org, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Thu, 12 Oct 2023 09:42:58 +0200
In-Reply-To: <22761c3d88c2c4dbac747cc7ddca3d743c6d88d9.camel@linux.ibm.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
         <20230904133415.1799503-13-roberto.sassu@huaweicloud.com>
         <22761c3d88c2c4dbac747cc7ddca3d743c6d88d9.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-CM-TRANSID: LxC2BwBnwJGGoydlzkoQAg--.30762S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1fKrykCF43XF13tw1rtFb_yoW8JFyxpF
        W8Ga1DKr98Kry7C3s3tF48ZayFvayfKw4UXrZrJryxAFsrWw13Kan7Gay8ua4DGrWUGr1Y
        qry2gasrXa4DZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcV
        CF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQZ2-UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAIBF1jj5DumAAAsZ
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-10-11 at 20:08 -0400, Mimi Zohar wrote:
> gOn Mon, 2023-09-04 at 15:34 +0200, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> > the inode_post_setattr hook.
> > 
> > It is useful for EVM to recalculate the HMAC on modified file attributes
> > and other file metadata, after it verified the HMAC of current file
> > metadata with the inode_setattr hook.
> 
> "useful"?  
> 
> At inode_setattr hook, EVM verifies the file's existing HMAC value.  At
> inode_post_setattr, EVM re-calculates the file's HMAC based on the
> modified file attributes and other file metadata.
> 
> > 
> > LSMs should use the new hook instead of inode_setattr, when they need to
> > know that the operation was done successfully (not known in inode_setattr).
> > The new hook cannot return an error and cannot cause the operation to be
> > reverted.
> 
> Other LSMs could similarly update security xattrs or ...

I added your sentence. The one above is to satisfy Casey's request to
justify the addition of the new hook, and to explain why inode_setattr
is not sufficient.

Thanks

Roberto

> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

