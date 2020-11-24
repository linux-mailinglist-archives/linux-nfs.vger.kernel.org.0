Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9782C3438
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Nov 2020 23:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725440AbgKXWvK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Nov 2020 17:51:10 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52062 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgKXWvJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Nov 2020 17:51:09 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AOMmRHa186740;
        Tue, 24 Nov 2020 22:51:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 cc : to; s=corp-2020-01-29;
 bh=Gb33Tp0xbS9nsJ/BKNRXLGw5P4QywqJzdhqRy5/hTFE=;
 b=w7nLE7uMye9g3+FLdaKFmUSJo4e4cUSCklVP+WpY/VKph3B7adUU0hezDGjJMtz7gVwW
 +RVBkQuSjYQLSH6iFi29prPWcOqsb5OBVQgRvY5hF4ygWi/BKIYtjhLyWxI6emobCDCp
 bWHkWcxxXtRf0dJmi2+bylChnuj4x6lFPRlzJPcxxGSCaK4bC7itOiv2lO584nz+UKe9
 BW8NalPcpHFXNIBVW8l0vzYuBRCMFC4Ix9JTjjiU76hAkBtAuPIDbXQIu0Lmcb29QOb7
 aJhXBhEYZ3HIwu5aAfivNoNbg+QjX3tl+8h5+w+7B7fjPgPIQBKJYcL8uzg3ndWhKa/Z Yg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 3514q8hxjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Nov 2020 22:51:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AOMowrl047194;
        Tue, 24 Nov 2020 22:51:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 34yctx3fmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Nov 2020 22:51:06 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AOMp5n3030974;
        Tue, 24 Nov 2020 22:51:05 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Nov 2020 14:51:04 -0800
From:   Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: NFSD merge candidate for v5.11
Message-Id: <48FA73BE-2D86-4A3F-91D5-C1086E228938@oracle.com>
Date:   Tue, 24 Nov 2020 17:51:03 -0500
Cc:     Jeff Layton <jlayton@redhat.com>, Bruce Fields <bfields@redhat.com>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9815 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011240133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9815 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1011
 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011240133
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

I've added my NFSv4 XDR decoder series and Bruce's iversion
series to my "for next" topic branch to get some early
testing exposure for these changes.

Bruce's series is based on 8/8 posted on November 20, with
Jeff's review comments integrated. The NFSD XDR decoder
patches are based on v4, posted yesterday afternoon with
Bruce's review comments integrated.

The full branch is available here:

  git://git.linux-nfs.org/projects/cel/cel-2.6.git cel-next

or

  =
http://git.linux-nfs.org/?p=3Dcel/cel-2.6.git;a=3Dshortlog;h=3Drefs/heads/=
cel-next

...and is still open for changes or additional patches. This
branch is pulled into linux-next regularly.


--
Chuck Lever



