Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEB57182444
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2020 22:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbgCKV5Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Mar 2020 17:57:25 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58920 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729328AbgCKV5Z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Mar 2020 17:57:25 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02BLmVxV097852;
        Wed, 11 Mar 2020 21:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=lwoDR+AyKoApEXoZL9utvBith+RSlhW0M1es4LTGjYE=;
 b=ONrQpUd7mWhGX+cKuVQXZps6BwAMjsz4GBr2+zNNHMsXuRBdYASNDcXD8SSRVnRfGW7W
 d5qPIR6mYI4j0nO2o0dy+CyoPzmxHlLrVSy/8ZdSMpMomyACyiFksxnBSb03Lbq+iIj7
 +gLNgRrgDSr+dxTqalhRFA+gcrHziQvuKAVPjypVo06ccScVjYRp2m1o+ChwWsGLleSx
 WuFXFDdEw5mVIFyJXl9p0+B+Hw8h36OIN7j92qU8u/QoOCL1ICV6Gm3RMsDReL1uxEoX
 EYcfU3nCEReW1ENQGVFe/8PURhqCSy0O5hdDFnSXCcyLY4wT8r9xya1abY10TdbVao49 AQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2ym31upbn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Mar 2020 21:57:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02BLo4gA020825;
        Wed, 11 Mar 2020 21:57:21 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2yp8qxsq9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Mar 2020 21:57:21 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02BLvKrd003498;
        Wed, 11 Mar 2020 21:57:20 GMT
Received: from [10.154.171.188] (/10.154.171.188)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Mar 2020 14:57:20 -0700
From:   Bill Baker <Bill.Baker@Oracle.com>
Subject: 2nd Announcement: Spring 2020 NFS Bake-a-thon
To:     nfsv4@ietf.org, linux-nfs <linux-nfs@vger.kernel.org>,
        fall-2019-bakeathon@googlegroups.com
Message-ID: <14e2971d-005b-db20-5aaa-f7ba44750ba0@Oracle.com>
Date:   Wed, 11 Mar 2020 16:57:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9557 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003110121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9557 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003110121
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Greetings,

Oracle plans on hosting the Spring 2020 Bake-a-thon at the Oracle
offices in Ann Arbor, MI.  The event will run from the morning of May
11th through Friday, May 15th, 2020.

That said, we know that everyone is concerned about COVID-19 and some
companies are restricting travel.  Therefore, we need to know how many
people still plan to attend to see if we still have a quorum for holding
the event.

If you plan to attend, please let me know ASAP.  If you typically attend
or had planned to attend, but cannot, let me know that too, so we can
get an estimate of the expected turnout.

Watch these lists for updates in the near future.

-- 
Bill Baker - Oracle NFS development
