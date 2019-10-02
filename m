Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60464C8C26
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Oct 2019 16:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfJBO5k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Oct 2019 10:57:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59428 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfJBO5k (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Oct 2019 10:57:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x92EixFL109822;
        Wed, 2 Oct 2019 14:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 cc : to; s=corp-2019-08-05;
 bh=8SgtUL2DdWK4gAdmaYBDzx8/pNT0ZGkX9Tt79bK2VFc=;
 b=X+7alQWf6jD9Ni3ZYTqVW8jpjG+b6tJkr3blnSuqeNEhQHv+dPThck8+3Oc+zW+hiNTn
 iXfcOrTvRLfDNHySQgjJqvXmxojKScGb+10p0yJmtiu8OeK/O2rnAHMUmmFOaSkbOCSj
 mGEndUjeCf8JVbjjP4L6hr6xSPI89LtNhuqZDzCUdaBT3sRiRSksCFEGUSUfV5p/BLTG
 mNjAOy0Zv8ONZI8UnpNo/eKKjLv06E21tHs1JdhckMifgDwxNR/cU95MyOK3FDd2RPZb
 Ei+edUSkIsJZkqVoV31suv2GF2872PhU7xPIQFEezqYHe/JHmYsrAI3wQcvB/UAZHxjG YA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2va05rwew7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Oct 2019 14:57:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x92EhvSZ137129;
        Wed, 2 Oct 2019 14:57:34 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2vc9dkp5cg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Oct 2019 14:57:34 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x92EvRVv005592;
        Wed, 2 Oct 2019 14:57:27 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Oct 2019 07:57:27 -0700
From:   Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: remounting hard -> soft
Message-Id: <489FAE7A-F9CC-46A9-84FC-127487ADC0B3@oracle.com>
Date:   Wed, 2 Oct 2019 10:57:21 -0400
Cc:     NeilBrown <neilb@suse.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9397 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=963
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910020138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9397 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910020138
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond-

We (Oracle) had another (fairly rare) instance of a weekend maintenance
window where an NFS server's IP address changed while there were mounted
clients. It brought up the issue again of how we (the Linux NFS community)
would like to deal with cases where a client administrator has to deal
with a moribund mount (like that alliteration :-).

Does remounting with "soft" work today? That seems like the most direct
way to deal with this particular situation.


--
Chuck Lever



