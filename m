Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27B5576A02
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Jul 2022 00:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbiGOWjo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Jul 2022 18:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiGOWjj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Jul 2022 18:39:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283073A4AB;
        Fri, 15 Jul 2022 15:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=WRMz9a04tnIAZ9GS7HQeuHPFonwLT/V6r2dd9lADBLM=; b=rShIO1yplSN4QJePNMjNPYAItA
        ixUkUMn5TTlqo8vRliL3vpqn2tmiKEgOpKdN0AuR5nXK2hTiR7pct4wAN+8be1Pt8KodI8hLoB5gp
        i4LhG14Zz1gR5wuO87Qz5Z/jk9paR46D36Q0RwY+GmDNO7K2GWsrDNJ3tqxBjntz0n2dQbCYZ1jJt
        xqwZmtHP0ZdCCyvVaTOQBp+WtFMTYhtY7eTnjh1GMjoEMLNpLwWY/AspSGx4iUp0j8ZsPqtwYGyKu
        ox54NaOTKHNydoxxFYLS/byPlHhi5eUYOL86NDL0enXRneZ7Ct2eWqj3Z55/masAy3aOx5zy+qNX7
        yXyiUVQQ==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oCTyA-00ApdJ-3H; Fri, 15 Jul 2022 22:39:34 +0000
Message-ID: <f8ac63e2-c6f1-0dbb-823e-543d6b1deee5@infradead.org>
Date:   Fri, 15 Jul 2022 15:39:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: linux-next: Tree for Jul 15 (nfsd)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, jlayton@kernel.org
References: <20220715225251.2e7f7ada@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220715225251.2e7f7ada@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 7/15/22 05:52, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20220714:
> 

on i386 or x86_64:
when CONFIG_NFSD_V4 is not st:

../fs/nfsd/nfsctl.c: In function ‘nfsd_init_net’:
../fs/nfsd/nfsctl.c:1504:24: error: ‘NFS4_CLIENTS_PER_GB’ undeclared (first use in this function)
 1504 |         max_clients *= NFS4_CLIENTS_PER_GB;
      |                        ^~~~~~~~~~~~~~~~~~~


-- 
~Randy
