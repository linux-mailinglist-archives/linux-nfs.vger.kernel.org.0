Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8A52B2FB7
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Nov 2020 19:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgKNSal (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 14 Nov 2020 13:30:41 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56390 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgKNSak (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 14 Nov 2020 13:30:40 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AEIFR3K154778;
        Sat, 14 Nov 2020 18:30:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=G2dREexVPXXv/X4wDAX9UbmrtZKMz42mO/ydz8NocAo=;
 b=LPUxtkTe3M9rrhbJpdfRwVAXOPpFqfnroDHPRaMGoUGWD3N1bDoQfQEzRgAYuhLw4OSI
 dlylaA5hRBebUYqkr4ANwRb7ulfxzGaFPLHgZRWxmrkr6KKwmbBdYy9ueF7mXGazG77J
 G9On3w4P8wKPNYePWxyZOv2xsMrqHpmDNecokFz5pAfGmKnzl8zCZl/Jgn5XjsymeKk5
 r0/Q4uEciiTB5H7JYlqYKfrciRRe0/mA05GOKVgSTG9i6kGja5fbhsTm0/g0RSzcQi/o
 68y24eK8F1sqXvF0rgtWaKZsWgqEC9c9ktLM5BWwJSqH+Ink0LKbMTkcqO+hR1cA1f7/ xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34t76kh4h7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 14 Nov 2020 18:30:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AEIF6mT173522;
        Sat, 14 Nov 2020 18:30:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 34t7203jqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Nov 2020 18:30:34 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AEIUYxG028823;
        Sat, 14 Nov 2020 18:30:34 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 14 Nov 2020 10:30:34 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v1 07/61] NFSD: Replace READ* macros in
 nfsd4_decode_close()
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201114092954.GB29362@infradead.org>
Date:   Sat, 14 Nov 2020 13:30:33 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <1932EF5C-BC27-4275-B52D-1EB82859149E@oracle.com>
References: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
 <160527978038.6186.4530707404283867683.stgit@klimt.1015granger.net>
 <20201114092954.GB29362@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9805 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011140124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9805 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011140124
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks for having a look!


> On Nov 14, 2020, at 4:29 AM, Christoph Hellwig <hch@infradead.org> wrote:
> 
>> {
>> +	__be32 *p;
>> 
>> +	p = xdr_inline_decode(argp->xdr, NFS4_STATEID_SIZE);
>> +	if (!p)
>> +		goto xdr_error;
>> 	sid->si_generation = be32_to_cpup(p++);
>> +	memcpy(&sid->si_opaque, p, sizeof(sid->si_opaque));
>> +	return nfs_ok;
>> +xdr_error:
>> +	return nfserr_bad_xdr;
> 
> Using a goto for a trivial direct error return looks pretty strange
> and makes the code harder to follow.  This seems to happen quite a bit
> in this and the following patches.

Question of coding style. Some people prefer having a single
point of exit at the tail of a function.

I suppose I could simplify these smaller decoders, but it's
subjective. Anyone else have an opinion? Christoph, as an
example, how would you express this particular function?

--
Chuck Lever



