Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C7A2AB340
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Nov 2020 10:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbgKIJLU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Nov 2020 04:11:20 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58922 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgKIJLU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Nov 2020 04:11:20 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A993pdl167639;
        Mon, 9 Nov 2020 09:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=pEbHLrb/uqYzCw7ITx+lfqOy22oj0OT0gEycaUlubs8=;
 b=yWu0i/4/s8hW0wUnECAxNP16BGjOIsoyhpYYHA8jnvXZ1y6aaeopCBnTwU7tKqg/LwpO
 8aFFMxGMNN8gFvb7mdWrfXs9wORfi16Z2WOF88Hnes4Wb7d782fAf2DYMUdaFrIX/gu1
 YCg4ikoOJDnWIiQYB4Oer3PODByOWzTJr5hLmnK4URWQUBtDpq/LOdrc3eWWyUH0YnS7
 G9Dzqt3mmL0eeDIMyVmUaXmo5rs1Grs8ApA7E9182whSx7jBMmcURFBYJbr5iHa6E4Uy
 4uESLXpkUCiZvKclic+BGMpclLpouWKasAcu27ipRyCuHdjHlsmnAMQxqQiB7eGd6fIS 3Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 34nkhkmray-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 09:11:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9958Qo169522;
        Mon, 9 Nov 2020 09:11:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 34p55kpyxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 09:11:04 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A99AxCS003122;
        Mon, 9 Nov 2020 09:10:59 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 01:10:59 -0800
Date:   Mon, 9 Nov 2020 12:10:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Artur Molchanov <arturmolchanov@gmail.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Colin King <colin.king@canonical.com>
Subject: Re: [PATCH] net/sunrpc: clean up error checking in proc_do_xprt()
Message-ID: <20201109090950.GJ18329@kadam>
References: <031F93AC-744F-4E02-9948-1C1F5939714B@gmail.com>
 <20201027141758.GA3488087@mwanda>
 <20201106203316.GA26028@fieldses.org>
 <20201106205959.GB26028@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106205959.GB26028@fieldses.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090059
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090059
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Bruce, thanks for catching my bug.

Acked-by: Dan Carpenter <dan.carpenter@oracle.com>

Do want me to do anything, because it seems like you already fixed my
patch?

regards,
dan carpenter

