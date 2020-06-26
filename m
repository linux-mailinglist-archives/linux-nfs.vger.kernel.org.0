Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA78A20B0E9
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2020 13:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgFZLvP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Jun 2020 07:51:15 -0400
Received: from m136.mail.163.com ([220.181.13.6]:16818 "EHLO m136.mail.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgFZLvP (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 26 Jun 2020 07:51:15 -0400
X-Greylist: delayed 907 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Jun 2020 07:51:13 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=eHsSH
        9qDfcW5toF8Yd4HT2Ucml9LISECE/7HtQhEokw=; b=jBfFnFETF0ZAP8lpTJxrX
        b+usPUH/hhMFdPoINua7/1h+JEd854/2zTCmPhaknEN2fI3VjfB/yzqRpvfP77UM
        qSrolEHUIYB7yTfem5FHFMclphVUy9e1zk6f9djI7nybVCudflztUsnDpKSSVGP1
        4Xnq9OQUZpRXRZ9ZT+8H5w=
Received: from lxgrxd$163.com ( [113.104.190.184] ) by ajax-webmail-wmsvr6
 (Coremail) ; Fri, 26 Jun 2020 19:35:51 +0800 (CST)
X-Originating-IP: [113.104.190.184]
Date:   Fri, 26 Jun 2020 19:35:51 +0800 (CST)
From:   =?GBK?B?wubQobjV?= <lxgrxd@163.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] nfsd: fix kernel crash when load nfsd in docker
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2020 www.mailtech.cn 163com
In-Reply-To: <20200624012901.GC18460@fieldses.org>
References: <20200615071211.31326-1-lxgrxd@163.com>
 <20200624012901.GC18460@fieldses.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <335d1aa4.27f0.172f06997c2.Coremail.lxgrxd@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: BsGowADXVHGX3fVeQRZKAA--.51030W
X-CM-SenderInfo: ho0j25rg6rljoofrz/xtbBEBJPUVUMSHAzBAABsL
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks for reply. Very well, the two patches you provided solved this problem.
