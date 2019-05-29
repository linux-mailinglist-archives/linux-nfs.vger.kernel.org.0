Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C623A2DFE1
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2019 16:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfE2Ofa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 May 2019 10:35:30 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:48772 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbfE2Of2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 May 2019 10:35:28 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4TEXWNg040740;
        Wed, 29 May 2019 14:35:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=t1SM7WRbXklRjxAdeqo6r3kJKmE3Wo2Su2FLQegU6OA=;
 b=nQsH3JSYAhSjyQiwTVWAqeUhKA27D57UfXHCTcoNkRM29ICDUEcsEMWqOV47IPbgAlaf
 T1U1KCH2Ga+UXNw4FlVkXRUX8c+IUL+T5OLuTdwYHJNv1eaS+qfK1cGA0dbH5Tf28367
 n53e2JQ+mQ2Ie4IN3ugddSSQDFkfcU+I099bG0gTpb1tx0z2mi3RU5O9z2GW8gKk0XTV
 cjy0qW8OlxYY4HhGJC7oEJCYXMKQZU/WigwjELG1sxQzRRYI+v8XB1L2O7P2Veou0MX6
 xWNlSWabLBQ6jvUWORiHlXd9FG+GrdTtFZo4niWW41ylgsRnV2MHkqPxaWDIVurBbqnp Iw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2spu7djdh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 14:35:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4TEXpLr138142;
        Wed, 29 May 2019 14:35:15 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2srbdxe6rr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 14:35:14 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4TEZBOr024141;
        Wed, 29 May 2019 14:35:11 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 May 2019 07:35:11 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH RFC 00/12] for-5.3 NFS/RDMA patches for review
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20190529064055.GA10492@infradead.org>
Date:   Wed, 29 May 2019 10:35:09 -0400
Cc:     linux-rdma@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9557E3ED-6C62-4C7D-8854-2DFC39ED690E@oracle.com>
References: <20190528181018.19012.61210.stgit@manet.1015granger.net>
 <20190529064055.GA10492@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9271 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905290096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9271 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905290096
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 29, 2019, at 2:40 AM, Christoph Hellwig <hch@infradead.org> =
wrote:
>=20
> On Tue, May 28, 2019 at 02:20:50PM -0400, Chuck Lever wrote:
>> This is a series of fixes and architectural changes that should
>> improve robustness and result in better scalability of NFS/RDMA.
>> I'm sure one or two of these could be broken down a little more,
>> comments welcome.
>=20
> Just curious, do you have any performance numbers.

To watch for performance regressions and improvements, I regularly run =
several
variations of iozone, fio 70/30 mix, and multi-threaded software builds. =
I did
not note any change in throughput after applying these patches.

I'm unsure how to measure context switch rate precisely during these =
tests.

This is typical for fio 8KB random 70/30 mix on FDR Infiniband on a NUMA =
client.
Not impressive compared to NVMe, I know, but much better than NFS/TCP. =
On a
single socket client, the IOPS numbers more than double.

Jobs: 12 (f=3D12): [m(12)][100.0%][r=3D897MiB/s,w=3D386MiB/s][r=3D115k,w=3D=
49.5k IOPS][eta 00m:00s]
8k7030test: (groupid=3D0, jobs=3D12): err=3D 0: pid=3D2107: Fri May 24 =
15:22:38 2019
   read: IOPS=3D115k, BW=3D897MiB/s (941MB/s)(8603MiB/9588msec)
    slat (usec): min=3D2, max=3D6203, avg=3D 7.02, stdev=3D27.49
    clat (usec): min=3D33, max=3D13553, avg=3D1131.12, stdev=3D536.34
     lat (usec): min=3D47, max=3D13557, avg=3D1138.37, stdev=3D537.11
    clat percentiles (usec):
     |  1.00th=3D[  338],  5.00th=3D[  515], 10.00th=3D[  619], =
20.00th=3D[  750],
     | 30.00th=3D[  857], 40.00th=3D[  955], 50.00th=3D[ 1057], =
60.00th=3D[ 1156],
     | 70.00th=3D[ 1270], 80.00th=3D[ 1434], 90.00th=3D[ 1696], =
95.00th=3D[ 1926],
     | 99.00th=3D[ 2966], 99.50th=3D[ 3785], 99.90th=3D[ 5866], =
99.95th=3D[ 6652],
     | 99.99th=3D[ 8586]
   bw (  KiB/s): min=3D64624, max=3D82800, per=3D8.34%, avg=3D76631.87, =
stdev=3D2877.97, samples=3D227
   iops        : min=3D 8078, max=3D10350, avg=3D9578.91, stdev=3D359.76, =
samples=3D227
  write: IOPS=3D49.2k, BW=3D384MiB/s (403MB/s)(3685MiB/9588msec)
    slat (usec): min=3D3, max=3D7226, avg=3D 7.54, stdev=3D29.53
    clat (usec): min=3D64, max=3D14828, avg=3D1210.36, stdev=3D584.82
     lat (usec): min=3D78, max=3D14834, avg=3D1218.11, stdev=3D585.77
    clat percentiles (usec):
     |  1.00th=3D[  359],  5.00th=3D[  545], 10.00th=3D[  652], =
20.00th=3D[  791],
     | 30.00th=3D[  906], 40.00th=3D[ 1004], 50.00th=3D[ 1106], =
60.00th=3D[ 1221],
     | 70.00th=3D[ 1369], 80.00th=3D[ 1549], 90.00th=3D[ 1844], =
95.00th=3D[ 2147],
     | 99.00th=3D[ 3163], 99.50th=3D[ 4015], 99.90th=3D[ 6194], =
99.95th=3D[ 7308],
     | 99.99th=3D[ 9372]
   bw (  KiB/s): min=3D27520, max=3D36128, per=3D8.34%, avg=3D32816.45, =
stdev=3D1323.08, samples=3D227
   iops        : min=3D 3440, max=3D 4516, avg=3D4101.97, stdev=3D165.38, =
samples=3D227
  lat (usec)   : 50=3D0.01%, 100=3D0.01%, 250=3D0.31%, 500=3D3.91%, =
750=3D14.66%
  lat (usec)   : 1000=3D24.41%
  lat (msec)   : 2=3D51.69%, 4=3D4.57%, 10=3D0.44%, 20=3D0.01%
  cpu          : usr=3D3.24%, sys=3D8.11%, ctx=3D786935, majf=3D0, =
minf=3D117
  IO depths    : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D100.0%, =
32=3D0.0%, >=3D64=3D0.0%
     submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.0%
     complete  : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.1%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.0%
     issued rwt: total=3D1101195,471669,0, short=3D0,0,0, dropped=3D0,0,0
     latency   : target=3D0, window=3D0, percentile=3D100.00%, depth=3D16

Run status group 0 (all jobs):
   READ: bw=3D897MiB/s (941MB/s), 897MiB/s-897MiB/s (941MB/s-941MB/s), =
io=3D8603MiB (9021MB), run=3D9588-9588msec
  WRITE: bw=3D384MiB/s (403MB/s), 384MiB/s-384MiB/s (403MB/s-403MB/s), =
io=3D3685MiB (3864MB), run=3D9588-9588msec


--
Chuck Lever



