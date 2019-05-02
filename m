Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CABD11AAA
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2019 16:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfEBOCH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 May 2019 10:02:07 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:37728 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBOCH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 May 2019 10:02:07 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x42Drld9044213;
        Thu, 2 May 2019 14:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=0nSq0kzqdxwXiYYsldtvVwitvvszvDIgIGmFM1J8Go4=;
 b=TaNNMa2B3szcnIGTjpzw1y1uhWHK5FEUEBlcSR2DulIaKvT96+earpB9CbzqWvqGVbOx
 AdEX4IKYdgxldbmlRba25NlSm4YTPHKwg3QyMNbAXI31CTjrJuMEd5gksl8sgz1Gxxvd
 d9Dy2vxr6LzweCNieFFFperDLIsKtfJ+LKcILhN4tVEvcMemNhql38e9L1/W0vY7fOrO
 htOyxx8D5TrxxlvoFakCqeFcy3DisS8ryorQfhsul2q8lhxVNo3lvzkvNTWaPWxX5oCT
 82JOZShN0I331KWTO+RLcmYwTg9v4okJIjt6DLI0HjeugL3zVQ3wxAcrG91DIRcP7gqp 5g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2s6xhygtmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 May 2019 14:01:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x42E0kBR104040;
        Thu, 2 May 2019 14:01:51 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2s7rtbr047-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 May 2019 14:01:51 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x42E1l7Y006859;
        Thu, 2 May 2019 14:01:48 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 May 2019 07:01:47 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 5/4] 9p: pass the correct prototype to read_cache_page
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20190502130405.GA2679@lst.de>
Date:   Thu, 2 May 2019 08:01:43 -0600
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <1CFA4656-2E3E-40D2-A0B2-A49F174F2420@oracle.com>
References: <20190501160636.30841-1-hch@lst.de>
 <20190501173443.GA19969@lst.de>
 <AEBFD2FC-F94A-4E5B-8E1C-76380DDEB46E@oracle.com>
 <20190502130405.GA2679@lst.de>
To:     Christoph Hellwig <hch@lst.de>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9244 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=780
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905020095
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9244 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=826 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905020095
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 2, 2019, at 7:04 AM, Christoph Hellwig <hch@lst.de> wrote:
> 
> Except that we don't pass v9fs_vfs_readpage as the filler any more,
> we now pass v9fs_fid_readpage.

True, so never mind. :-)


