Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3795A2C0F51
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 16:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732466AbgKWPsO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 10:48:14 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:58604 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732217AbgKWPsN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 10:48:13 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ANFjFvQ090353;
        Mon, 23 Nov 2020 15:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=UYXMNudr+fmMNCrNXFCCKL7y9vwWlKg3QQjFxNjQPPU=;
 b=TX1N0NM/QABsiYxXuO8MX51Ic0pi+i31EzssfAaXbiPjvEira/F7nVP7xRnUs0XIJY30
 sCCnis8hgDlHg282uncr2qxvbGjiAdryLT6Ik/5fQu7sbzcnq4FNsyYvAZPKXbE3Athu
 1Mfm+QglSe/aDJV6Oz0fe/GwKCV1LUWdRve2NtS6psguZmKOGvlrl4TVuA3Vy9YO0/vV
 u3LZ28keyc+5uFbxg6BduX5QGZm63J8hhHKJKUFjygFVD3C+BKiIL2SmfW8WL3DQPlzh
 XZ4M7maFTrUEzBtHqWB+hUWAtcaYH2mH9zzjFUjgbD9jDdIe8JThl2tv415ogVUZ7VNI Fg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 34xtaqhcwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Nov 2020 15:48:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ANFTprm160004;
        Mon, 23 Nov 2020 15:48:09 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 34yx8hk6vp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Nov 2020 15:48:09 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0ANFm3NI017898;
        Mon, 23 Nov 2020 15:48:08 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Nov 2020 07:48:03 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] sunrpc : make RPC channel buffer dynamic for slow case
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201123153627.GD32599@fieldses.org>
Date:   Mon, 23 Nov 2020 10:48:02 -0500
Cc:     Roberto Bergantinos Corpas <rbergant@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <F4985547-8F5A-4694-8785-E05E5BC5390F@oracle.com>
References: <20201026150530.29019-1-rbergant@redhat.com>
 <20201106215128.GD26028@fieldses.org>
 <CACWnjLxiCTAkxBca_NFrUSPCq_g4y0yNaHuNKX+Rwr=-xPhibw@mail.gmail.com>
 <20201123153627.GD32599@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9813 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011230106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9813 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011230106
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 23, 2020, at 10:36 AM, J. Bruce Fields <bfields@fieldses.org> wrote:
> 
> On Sat, Nov 21, 2020 at 11:54:30AM +0100, Roberto Bergantinos Corpas wrote:
>> Hi Bruce,
>> 
>>  Sorry for late response as well.
>> 
>>    Ok, here's a possible patch, let me know your thoughts
> 
> Looks good to me!  Could you just submit with changelog and
> Signed-off-by?

Bruce, are you taking this for v5.10-rc, or shall I include it
with v5.11 ?

--
Chuck Lever



