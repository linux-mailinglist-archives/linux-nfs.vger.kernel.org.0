Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7A130DFB1
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Feb 2021 17:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhBCQ0j (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Feb 2021 11:26:39 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50398 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbhBCQ0h (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Feb 2021 11:26:37 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113GEjcB113192;
        Wed, 3 Feb 2021 16:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=m30P8DcyfQCT6/wiDJSLpfBkC43HWwu5rPGhI7c8k+4=;
 b=Me66ZkzWK6Ko0VAi5M6HVgbamKC5ILi8f2HXAeAI9N4Xk3LIPNRKEMx5hxp6CnW6umjt
 8h1xnFGZ4YRFWgWo/THZTgwctkPq21rLKmJdDXJl30TSFHBHTEfdKN1fquXBhFAHrcb0
 WvtZtIYtIJDNGuvya22h7Wjf3AQk5D9WOIhYWh/xlgKwMi429BALpmgyqSrUW4+aqFdm
 N39nKrhq1Vi/zRB8L7ICM4M5fqs0VFwJ4FOeWTmTodpGFQKdO7VpqcYHAMBQtrseRidg
 QK/IKjdsLR+aiqSR5xuM8+Op3rW5IsE3x/9PFJZ5HNC4sj0sZ5swyhHJgjIqjAXzLKLq Tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 36cxvr3ksq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 16:25:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113GGGwM111462;
        Wed, 3 Feb 2021 16:25:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by userp3020.oracle.com with ESMTP id 36dh7tr65s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 16:25:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJVRUf2hohWIe4Mtv9Hw8kbSagrg3zkzTr3UiwaTJDXPrIAH+hr3w2D1Jono9RmRSOMDZV0CwoS4at0TUIkP+CPwEIGM3/lvB3lF+wKV5Y5Cu7peOo3PwBGQPDQ9KQKeKairqEolE0WfVR2uWMijBJttJhCyhZCTUubHB7bygXDe3z/Y8br3fnfgpzAvCiReBlukn6MXDATfyPEF/DRnoE45Id35Tzc3sEOa3tLs/1M4iHAkb4mvnUrPaGxWg2BayRRpAn9iCGCVvbSkv3gUT+F82A9LsSy2ukDEJYak0URCarIyMnP/aFDorH7rrYt7cfqHgI712ClhRi/I6QkYpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m30P8DcyfQCT6/wiDJSLpfBkC43HWwu5rPGhI7c8k+4=;
 b=cEiktYOwcV5KArpzpwMx2Q3aVgx9JoX3qls947iDa+306Kd5bqiuv+Yx8ohMQ5AN9uLdF4Hai5Kev4Tb2TBLkkbSau7v8lyidfhykGEhK42cNAaOiAjdMHu3qaIQJuNMj/7ONN+VJdwdKE9nk9cy48yJFOMzUPHowQ28N2m4roX0ThrdrEyACjw5oRlJv12qZrO/8A2wTrNDQVIiZ4Og+/G0zM2LnZq/qvawtJfpQnakhajbmYzau0eIrMA+2sMvENK/amYnHterTvFPxhlublz3CWwUWUvH8ueHBUUBjg9d3trTV9eP0JOieF52MpTP8IrUG3dIMTY1lfo7eaLqtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m30P8DcyfQCT6/wiDJSLpfBkC43HWwu5rPGhI7c8k+4=;
 b=rMENvaN5IW53oBb50+QgELYX9nX4bG+NGi3Mj2ERA7Sy1cJUfH8BOjxMsuBtdGt/s3TxZ3N0OBgf8YlqAWRJHtnEQ98zoPtw6ypGilUThtQirkO1C+AyVnLQKxSaZ1ioa4s+Y9a2Levu7E9K7Qd7OVASaNlfvAzCV4V/+Si+l5s=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4164.namprd10.prod.outlook.com (2603:10b6:a03:210::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Wed, 3 Feb
 2021 16:25:50 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3805.027; Wed, 3 Feb 2021
 16:25:50 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] Series short description
Thread-Topic: [PATCH v2 0/6] Series short description
Thread-Index: AQHW+kjwDDafscgcxkqo/J3By1xHg6pGneSA
Date:   Wed, 3 Feb 2021 16:25:50 +0000
Message-ID: <EF605E4A-D9FE-4D63-9572-BA6EC10E8F45@oracle.com>
References: <161236921379.1030469.17739946617932155431.stgit@manet.1015granger.net>
In-Reply-To: <161236921379.1030469.17739946617932155431.stgit@manet.1015granger.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1031dd4-7163-4ed7-03e5-08d8c8605ee2
x-ms-traffictypediagnostic: BY5PR10MB4164:
x-microsoft-antispam-prvs: <BY5PR10MB4164D1974FB01665B611801993B49@BY5PR10MB4164.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ll3+A2cGXHW+n8kcuFiVlv5S2E0796zaG/ANhtMqXF7p3uLHnUPIP0K1KK8NV9XWWx5bcvtmn2DBOJNkNTNss4j0jk/rE7zMVTzbTHabQ/JAwog8ANnPPdLzBNqEZ/ap7u26RWaaED/Czsf1+0k0LhU6AQZQIBNiE/Z+Qyk1ocKkxKARbbx7Num/zhIX6+Is1KZBhphBODuss+iTrArlgjdlA8lOwtkBRTBu2jpR4LgU5n/ZzMmldJZzfvGk8CfJwq3KCb9U0aPOTSoT8NBL9SMueTZdUvd2V6CZ4d51XGZDo4i74X1zLIG6VydJpYvzeVg4JOVEQ2fRIFbLH5VlWvzKJlDWsEHw13FvxSYBGcpQ05VzFRmwX7OjXf4KE7PqX5hsSHEk3JG6EdE1/f9I4AimcuE48QNj2l51V6ro5PF2sBOG0WDq7TjMtmtuDsaK0tSWoFd+QHZhldba3Mp+ZHIDYpOG2OUduRMCoC2q0nG80wWKC+4kAPBxZkDpqiWEHe/bIigy2vcW24N46cL9HiJWo9tbREphMa6qUX7eLXE4EQYvIubPmwm0iqj9kji3yyaeSZtSET9wyO2+A4NJvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(366004)(346002)(39860400002)(5660300002)(76116006)(91956017)(66946007)(44832011)(478600001)(316002)(71200400001)(64756008)(6512007)(66476007)(2616005)(4744005)(36756003)(450100002)(86362001)(66556008)(53546011)(8676002)(26005)(6486002)(186003)(33656002)(83380400001)(8936002)(66446008)(110136005)(2906002)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?NRkKISGJhKJUevNPjFwmnqoIgugHPTH3c46oiGZ4bhTaU0V1rOdUKxJcYNiC?=
 =?us-ascii?Q?e3p3vKp+9O133pJ1K8/ELvhR0kj4qEH7jTc1N/6FW6A/jdS81nvPJ/IPmOvg?=
 =?us-ascii?Q?SubKOIlqIkwrXolDnQOye73KkNb9JNzM6ylpHTdVBROIgFbzAt+uqA0LEIry?=
 =?us-ascii?Q?MjAn+zPM2jeeFS4RfClAOeZB/iFyZYXpOIhRYqILZuOwzGahws7LLVtMnh1S?=
 =?us-ascii?Q?d+wGU3oid4MxY2Xb3jfJ3ndvA8Tyz+r6OQ3+50EfhTJD1WjketCyqdl6tjof?=
 =?us-ascii?Q?ouTJrgj7FRbGri0wSKoEC0hwzwEtFWJqcqdfh+Q5oNESkPqp4vVj83wXGdBa?=
 =?us-ascii?Q?Km8jIhDi8gebJFVwvrgAqc/B9nMokZyXPK2CsJw7a4JI31uyQbTolaZiwVhK?=
 =?us-ascii?Q?d9ZRRgyr90pZrp0rfwl5hXWHh3jakY5l6wrB6XSaSv/5Ex9x/NVztEeW04m0?=
 =?us-ascii?Q?wZIMSgAoxWQqH79hDB0CmUYGB1QgpwgyfcAxe40E6mnAlramdo6MGh0/uj6j?=
 =?us-ascii?Q?AxesksiDP4R2i1bd3ToCjKss4KzcNCXsj3J/Ddxsg+Eo2avQf5yIZDB870P2?=
 =?us-ascii?Q?yGyXDUfNlcALX4gXjv+WHJ1ecjcaIC1HP8O6WSi6uGLZIMbZJ17FENIH1NQA?=
 =?us-ascii?Q?McGI2HMDbFkxdUD+bH/lvbp6wsM2TVbpPtovegWdlWo9QcUeLFzwILwWeMML?=
 =?us-ascii?Q?3u3uITv3nTnT1ka1kX4F8jtQaWheKpJ4NulSPLqiQR31Ub5b9H+jbDrrgiI3?=
 =?us-ascii?Q?Z+5x9CzMVs4TPtamT8/LGVAhgcm82cix/INV+GxvVl3UwczENOM0ynAZrduB?=
 =?us-ascii?Q?4a5gf0Xn1XW5hs8VHbGnKlvtjIqkjWO3Bjf7zCa2doCyaGgEbC8CT3enYGmr?=
 =?us-ascii?Q?c2HefYH5oOKszlHf4HHLOgKpO/6T7u1+nh2RCwAXHBtTNPFmP6qFs7665Oeh?=
 =?us-ascii?Q?fbPeSGwdYIi0rtLCxvwhQyOsqOMUaTodgm27csGjeqgOdIcUTmyaaiqq/vn+?=
 =?us-ascii?Q?jq7ejQjzKxKwjn/Av65ZUORBuE+Jav/FTESwJMlink+5R+lvmndiO3dg6HzT?=
 =?us-ascii?Q?0MAqRV05J0arEtbbZFPC4Vd/Ez/TWA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <74B6DB6FF33D744E9AB6A91E0A05F40A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1031dd4-7163-4ed7-03e5-08d8c8605ee2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 16:25:50.6574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hkhy63guQjUDPPcCTR1vXz5UbG4pQFCGWobzbVC+4zlB82Q8Qvu/QkLx2PAnly1s+zCX5LxoeBHjaPrEYS3hIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4164
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030099
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102030099
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Misfire, please ignore.

> On Feb 3, 2021, at 11:20 AM, Chuck Lever <chuck.lever@oracle.com> wrote:
>=20
> The following series implements...
>=20
> ---
>=20
> Chuck Lever (6):
>      xprtrdma: Remove FMR support in rpcrdma_convert_iovs()
>      xprtrdma: Simplify rpcrdma_convert_kvec() and frwr_map()
>      xprtrdma: Refactor invocations of offset_in_page()
>      rpcrdma: Fix comments about reverse-direction operation
>      xprtrdma: Pad optimization, revisited
>      rpcrdma: Capture bytes received in Receive completion tracepoints
>=20
>=20
> include/trace/events/rpcrdma.h             | 50 +++++++++++++++++++++-
> net/sunrpc/xprtrdma/backchannel.c          |  4 +-
> net/sunrpc/xprtrdma/frwr_ops.c             | 12 ++----
> net/sunrpc/xprtrdma/rpc_rdma.c             | 17 +++-----
> net/sunrpc/xprtrdma/svc_rdma_backchannel.c |  4 +-
> net/sunrpc/xprtrdma/xprt_rdma.h            | 15 ++++---
> 6 files changed, 68 insertions(+), 34 deletions(-)
>=20
> --
> Chuck Lever
>=20

--
Chuck Lever



