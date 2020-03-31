Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0E54199959
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2020 17:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbgCaPNy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Mar 2020 11:13:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52082 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730391AbgCaPNy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Mar 2020 11:13:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02VF9Yc1029921;
        Tue, 31 Mar 2020 15:13:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=JE6lEo5ufkuNoWn1b3sE3qiqDhi8RGA0D2YLdXl8Z4Y=;
 b=DgTGLS8ogw6hIyH2er4ETm1aR1nzFj3jOutUvCCEuUTRBv3FHN0tbV+xXzvu4fjTABGt
 c34fyjhkI66yf46rhyilMcsoGeSofosblzVFj1Tr5WVQImWYfuOajgdByEDAOfi/2Xlg
 jF1FIPJDF4Tsx7mQTn75uun46LV/3fIXi4hyAebOeZN8kjVT0HPvTOvTlsZSEuO3j11o
 19rROgjsOODLRR4up8f5TytojWCdE5kArsoBgMw07Z9qVMPpoKxekdLWemgDWEjZsAtC
 zKVJoMMikIX/LINtLU8cIjxotbDPxdfX+Ebt/n47dCJspOgaSMi6gA2UJc2HcjY8PYI9 iQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 303cev06rg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Mar 2020 15:13:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02VF88hM086250;
        Tue, 31 Mar 2020 15:13:51 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 302g9xfpk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Mar 2020 15:13:51 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02VFDmg4021760;
        Tue, 31 Mar 2020 15:13:49 GMT
Received: from [10.154.102.16] (/10.154.102.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 31 Mar 2020 08:13:48 -0700
From:   Bill Baker <Bill.Baker@Oracle.com>
Subject: Spring 2020 NFS Bake-a-thon is CANCELLED
To:     nfsv4@ietf.org, linux-nfs <linux-nfs@vger.kernel.org>,
        fall-2019-bakeathon@googlegroups.com
Message-ID: <0416304a-6b42-9fea-71b6-c36356d210ee@Oracle.com>
Date:   Tue, 31 Mar 2020 10:13:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9576 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=945 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003310139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9576 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003310139
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Greetings,

In light of the ongoing pandemic, the Spring 2020
NFS Bake-a-thon is *CANCELLED*.

Stay tuned to this same BAT-channel for announcements
concerning the Fall Bake-a-thon.

Meanwhile, stay safe.

-- 
Bill Baker - Oracle NFS development
