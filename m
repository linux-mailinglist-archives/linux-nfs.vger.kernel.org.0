Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDB97C618E
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Oct 2023 02:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376728AbjJLAKL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Oct 2023 20:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376738AbjJLAKI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Oct 2023 20:10:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2377A90;
        Wed, 11 Oct 2023 17:09:51 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39BNo37E004682;
        Thu, 12 Oct 2023 00:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=mkGQnrH1qr4QBmNTXUp3QbC8Azh6txyGm/8ZAO5n3OM=;
 b=lPra/Q1fjaCsCvNkR+ie6SxfcGm6VfP3Ue8Xw0+R1Gmcruw4OcL4WdCxL1+3H3X7p7mC
 hkr+JNpBO1kz0nPmd4MnoxHNP44Fcz/P5fkN+x0qymXkanFEHxTAvkyZiy/gBoTIoOea
 gXSKkEcZHUVkPez2KTNfyWnbPO/iYZO7x9DgltRU0eYzTd6qXQJ35NNw+hZYRB3U+5mm
 g58iA7GaTXOC1vGIMWB4DhZTizOOTccCu7tJ6urAa7Ogt5RGmXcD9AhIiXsxU/OXL/xR
 BKZMoYfsdzvXuewrNrbTzFDOx5u6yNt7DwBYoOw3+DMZRJhqK2vXZtoPygZOG18fF/KO uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tp5qm8c0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 00:09:20 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39BNoD3O005461;
        Thu, 12 Oct 2023 00:09:19 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tp5qm8bym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 00:09:19 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39BNaAAm028191;
        Thu, 12 Oct 2023 00:09:17 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkj1yc1pv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 00:09:17 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39C09HgF37814734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 00:09:17 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17B1158052;
        Thu, 12 Oct 2023 00:09:17 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E5D958056;
        Thu, 12 Oct 2023 00:09:15 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.14.38])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 12 Oct 2023 00:09:15 +0000 (GMT)
Message-ID: <6cb16d4d9293f6896cb6db7f6eed16dea7cf453b.camel@linux.ibm.com>
Subject: Re: [PATCH v3 13/25] security: Introduce inode_post_removexattr hook
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 11 Oct 2023 20:09:15 -0400
In-Reply-To: <20230904133415.1799503-14-roberto.sassu@huaweicloud.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
         <20230904133415.1799503-14-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0qzwxvVDLYpSIALPB0izvBne7u7fcBOK
X-Proofpoint-ORIG-GUID: r6i2U62e13fIkJ-Gz6oitU5vZJ8XMCdr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_18,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110213
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-09-04 at 15:34 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the inode_post_removexattr hook.
> 
> It is useful for EVM to recalculate the HMAC on the remaining file xattrs,
> and other file metadata, after it verified the HMAC of current file
> metadata with the inode_removexattr hook.
> 
> LSMs should use the new hook instead of inode_removexattr, when they need
> to know that the operation was done successfully (not known in
> inode_removexattr). 

> The new hook cannot return an error and cannot cause
> the operation to be reverted.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Refer to the patch description comments for 12/25.

Otherwise,

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

