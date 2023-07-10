Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD7E74DB40
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jul 2023 18:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjGJQj0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jul 2023 12:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGJQjZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jul 2023 12:39:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F4393
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 09:39:24 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36AD9hqY005734;
        Mon, 10 Jul 2023 16:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=K+SJR+5L/hhOzFjtuxV0Rp/fs0e2J4LykNej4YgY2tE=;
 b=vsntARArfMZ10JznlvtdTzwCd86FDKJ+W6pjOlbKQDu6eFeLo9Aeww5sO+xd7wmgqTP+
 hkWkLEfW1KOACmKXPUS7kus9TpyVRpCQniEa0gbUFYKk7bjxd1HIRVDiXdk1zHRMgQYC
 OD6VJUYpHWvzqwb8+QzTuMQVt1Wl2vH1j3b1/8UN8IsM0asS7FgwQUnAAdZwHcexKnqd
 zye9PNfCqSAPgqgcEZfD+L1TnDBNskjHeDBBqa14YoW2G/Jq1Da+VaMhyV3cur1oRbbC
 3nR05ERQtI8LDB3KMBWunyPYxVDcthrfjXKfHf4TMgRUGxwBcgSTSARfElTED7vmGFQt UQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rrjmh8h50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 16:39:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36AFlofI022889;
        Mon, 10 Jul 2023 16:39:19 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx83qmmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 16:39:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRxUAasjCoZCCT2R1qYDfSAcGDc0RLjY6/XQaiVAWyp5SoJwqisQtjGS4JhMyAKPqlHBVeyYHoyNF+WEsVWI4umPSzQZym0L7k9bM542EKT8ZoAGzQcMeOXCvNoM6pbca8BpkgoQYyD1Xp3Fe2Lzjl63lLUoM/HeQpNQ2NmitlmmdrcjxJFymeBUiVaWEi0CRT63gMAOQyfQJ9eGdhRHcR+OG1x23rrQBuH+35BGsRp6TL/ydsWpLUCiq6ORz/DpacQknRv+HLOJLLZAsRfZDnH4flMEMQI/BNU4v12Fl6cZpVGqqZ0Zq8b/nEG3FDuBcfn/nXRyrludn2D+6VDhBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+SJR+5L/hhOzFjtuxV0Rp/fs0e2J4LykNej4YgY2tE=;
 b=aQZ5HTZkjNkS7ioNoB2ziA8cuQVN7JX3zMj9EIY1US+KukK4XFXmneAN2e/M6+cli2YdEJkVPcnMqCTYgxuCa0kySS9R3jWdmUIawIToxUTG+9JuDX8z80Tbif6vUxQhgZWv710k5MkOz2TQ2aOAXOQbC6fBxPnnkzOJjpjEevK3aLReuWzfPVDjGTz1YfMiPj1xKCFlbTZEmD7v+uvlvCMF7kzxeFe98b91qZVmDkWyrPs6YeLCXHmjHM8E/WN0d+FbJnDExglAKhxalfmPvWKpMBkkqcNT5WEBaHLM6mM+15nNH13CvAGuV7YjQ2cdIusLOiGkXEtrnGUF2aUnBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+SJR+5L/hhOzFjtuxV0Rp/fs0e2J4LykNej4YgY2tE=;
 b=SnZCG9T9J+wAxMsFITawVIz36M1D/YAldB8CMDYPr4z7dnUkcP2SlTIdanNisMP1bMeiitBqqZ+z8PtVVr1YfZc47BCQlJxB8lSUG0zcB5Mf82vRKydQOvOFl8aL/VEK0jIEm/WvFOl0g8zzcQ3iFqhBijIaWIbg4hiQgbqkWqA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5376.namprd10.prod.outlook.com (2603:10b6:5:3a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 16:39:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2107:f712:a7c5:9ac7]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2107:f712:a7c5:9ac7%3]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 16:39:16 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>
Subject: Re: [RFC] NFSD: add rpc_status entry in nfsd debug filesystem
Thread-Topic: [RFC] NFSD: add rpc_status entry in nfsd debug filesystem
Thread-Index: AQHZqnL2PhgnbC/p9EORLOfjtI8RFq+hzdIAgBFk9gCAAAY1gIAAC36AgAAAs4A=
Date:   Mon, 10 Jul 2023 16:39:16 +0000
Message-ID: <D72CB5B9-F380-4CBA-B6DE-0059B710B6B3@oracle.com>
References: <bac972c22c5acfa43969bb1bf164341b16ea045c.1688032742.git.lorenzo@kernel.org>
 <ZJ2NUPdX0KqvaUlr@manet.1015granger.net> <ZKwkulG5mZFRnFFD@lore-desk>
 <E916B0DD-7470-4F2C-A7F8-13DB070CC593@oracle.com>
 <ace2422233a24b7506f77e820e09c3500c617b10.camel@kernel.org>
In-Reply-To: <ace2422233a24b7506f77e820e09c3500c617b10.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB5376:EE_
x-ms-office365-filtering-correlation-id: 14a6da43-9e3c-474f-0dc9-08db81643397
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z5UI4g6rj4hKHqw5TOngKveyCKOTtc4DAyFEwkCazJxNtz4EhPGr3/2z5TYFtRwP83RxvbDhnFRm3xxPUmGjO3AsxM4SW8AGU0KxOGiKx+IDizmXPnWSrlajEoNNhzySyUhRgybrW+elEzPr3TI5DYQ3nimQd2G8+0tDpwikheBSFLVuNWqeUwcmBY2d0HiNYzC4wB9rW6iuURF3yFPHlRF83KE5joBpGY+U3gLxrRvHP0FjM7ykPMt4MWFXoTEjMrkvoUztO5gjvQCU01BWG5s/BkuqrSEqqThm9BcRdXK8PljbkjLxjqBEijksmfzckjFW4Lxbo+cGwdmWNpQUes/7OxzQ6hdMw2hxkLDIUFrFNqADAJ6cE3msGsQiaLVi56481MgD52js8JLTO6QCdfBkPBzPEJoiDXagzCS9sHR2kiC6LISqZS8ii+dA/yK2CPsA0i7WhwtD5rQzMQJIGEeu9Nozm+uUifykp64Lg6RJzTn//jxldZqHtrgCIAqC6jpPFFhOGlmNEc0Bla6UQuxTfCmRn0YIvXv1My4dWHcBU+a0VnMqYl1TxkFuQnw4aeolAxinB9ZeHf5Sp9UDqJ28/cIVX/Icy9yaxfn5P4GAdHlhtHbGF4rcFtEfTO/QOLgB+fa1BdQ5rVyE79g3eQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199021)(86362001)(38100700002)(38070700005)(33656002)(36756003)(71200400001)(6486002)(54906003)(76116006)(91956017)(122000001)(53546011)(26005)(6506007)(186003)(6512007)(2616005)(5660300002)(2906002)(66556008)(316002)(478600001)(66946007)(8936002)(66476007)(8676002)(83380400001)(4326008)(6916009)(64756008)(66446008)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Iyvb+ZgWAfOSDRuE5IHEj5N3q30X8P0yGRtCbs431MbI1XY6S905vCYNmH6T?=
 =?us-ascii?Q?zNNJUyNKcVxzjex3gsGXZb2VqPc8WMxvekhyrOo/DmBda8wxqqpwRFbdwxSa?=
 =?us-ascii?Q?am9BjMS5g0c8E3gOjM8X3DXvHSwmjn29jQAnxAW49LLNIFPXGYnr+WgdsCUg?=
 =?us-ascii?Q?V+BJQ9Ubo84/wrlePHO/87heIoIgBGEPI6tovgrlo6nlyik+tpje9hatc3g8?=
 =?us-ascii?Q?c/r7sWjDZPFCy95k1YK+KpbHtoQREvlQGDKJ+AzWokSaWRLYjOOKWx1mN772?=
 =?us-ascii?Q?T5bPNradmN0cPOp7PPMiPM27NAIH1mGcaczbInKNR7SDMZ3mJRF75tT2ySKo?=
 =?us-ascii?Q?IX6AlhGZQLqTx/4tj+Sfph0AEijOA/HRe/VIEAquEYz1kV1tdrHxmc9r6G4b?=
 =?us-ascii?Q?UbDKuMT0cfkGZi7Ip8bUGPWyssZPZ0YEYo5XOkLVkFJBn26Hd3dpGjZ82taA?=
 =?us-ascii?Q?H6d9clXyNNj3irxpGB/NDa2lHEz+MgZAFqNwJ7sJ+oAzCDQIfxW1aznzbok4?=
 =?us-ascii?Q?YYJzj2gLxhVNspdYw9UkGgmsnQXL+KHjaW6uX/AzGBUFuBHy7QyQ73MFuKiA?=
 =?us-ascii?Q?T2XcEjmuLK2S8lFVWE4Oi2goyn3GDD0Hc/Fzhb0UJO5Mwr5jlTpLEFRbuLmV?=
 =?us-ascii?Q?LZRvyGh5Lf59EuTxZ9TjXhLi6sG+LYw88Cr+IQsiKmBLb9Opwjx+Kfagfuph?=
 =?us-ascii?Q?o04t0s/pyzBchzdInPdLUL2aD3OFGuAq8u80MXXI5xlRsb2OS/9v2H47QZNE?=
 =?us-ascii?Q?89A8UaCCjQtd0g1Td2/NBVEP8tM4iE+jDOXoi53uz5kZweACuGAgLGSUY7Nb?=
 =?us-ascii?Q?ZoRzpLkvIlvgN0VEwlPB7cpZQY+QeecOTVApp/dzDk4sP0z7cfsEbAWc1ohp?=
 =?us-ascii?Q?8vXV6KZclds/OzLdGRpc3ukmD+0FJsa/5nPRgkKAY5jyHLVmGFBsSj1go2xp?=
 =?us-ascii?Q?Ic2Qgjg913dNMG/+T/3IcpxtB6K/f67FznuBD8GZ3en/q5Cn+uQv/lelq0Es?=
 =?us-ascii?Q?Mew3kxl2HPmLgexvzQFDGwfwrURO6dqSn4PVip3SzGtDxwyEoKif6fdxUT/6?=
 =?us-ascii?Q?et5+mnM454E2wCBz80TXQ1Asxmm7Qchw3R/zWy/1+yZ2g0UTBgpHlWlsBgP1?=
 =?us-ascii?Q?rCjVGHGlYkJ+ptCchP3pcfV16A1k/WfQuFddzrx5IoyeQaRFgcduYc4P6vZf?=
 =?us-ascii?Q?M+SpP3PvBQ+fQBcvYuTS9JxTyj7D3HDNkMbUn+brSMqzNkazYN5FSwFcl22r?=
 =?us-ascii?Q?biPNP5yufKQ3PggdUv+wIsqWo+E/5KxHeBhwspR+8272YL4t20buGJuAa3uF?=
 =?us-ascii?Q?Zc1Suucl9dC5H+9brHiI7cDFI5liC/CmWzM8U1klQQwQqY8nyWFlp9zkJmqi?=
 =?us-ascii?Q?VTPmEQtUEmhasiZ15uv/b+6Giz7f76TqL6q6mG+u2vQRrb8wTLp46bibFxjM?=
 =?us-ascii?Q?hwy4RX5pT7GGTo0O3TYxRT91jDTFM2G6TbbQnGSE05hKm3gsDZXS9Xpzln81?=
 =?us-ascii?Q?3uXa3zXOz1yPuYWIXdBgH+6ev/WAXvSuUfKU81ByZ/PJAhr6222nLZKWHkm2?=
 =?us-ascii?Q?D2VFzBhwIBRu1gUCe6RdGEjJ/4OGiBt1ovhaN6IlaxCZVSp6QqvMvf/qQGjt?=
 =?us-ascii?Q?Zg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <57AAC2781A881145ACEA475FD005DF63@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JZ/CSdcsHJ78HSQdtwLEBSd2p1QT0blnSnkeCeVgIew4hlcJhfuER4A4Um3SG03noZCalUzKvMC0/vdnwh++fB31Ptl8arjn4oFeEz4/lSx06g8BN+VfbY47lX3zrXhrQ3gt4bcYETXMeDJ8o3vOZQhwEBZiy+lcwuY9Xqd95m9/oZfsUIANMyydmMt1zXutq4GRgQLkgLQZ6nibscc9PMCKYLH8706GsSHUk0NBE9lGZaK/QRg0nZkj+sAE35U1TECUSmy714UGYJyY2WAErJxR845pqCIQQdQZzK5JhqC7TuTXdK2GOG+qFpwoy4oY0BY08Ep6sfSIP4oLd2Yuk5O4LOPnKVnJ388x7UYCZTVwTmYn2pqligNlXUXkF2WV0te3wJ6MJdLYYn5zLmf21f9Pkoc8dqtpSl0wZ11SWpVoY4W/wPIWnOHBTr2j7GPDRbGB+pgV+wyYhszOioOp2pBnrxHSzhx/i2g9HozR6jh3gxgcJ2QtqnD0BVVKDfpfCk8Z336g51TNKQ/C/i5xmm2fF9OkJf33Bf+1lxCPad66TjqVrSMkqbY1QD60OJpdNH+2xBn2cY0fU9V+lMsDQDH/yz2t9CrAmf3E8YiArj3C8/6ZEwppO9DHyMsZRFDIyWb+UDXeYNahdUaHhDW8HSI2WUb6oVlNzfNgATwJXdShUNvMpW8eDSzAxeliXeaF7x/b0um6BgSiUf6WZQoH5n10bMPKv94HeepEBb41Ep5yEddCEXG3aVX/b5aAzvtiyHmsztXaAI9EGsuDJZDYrPP1pCO1M659QGZ8GVeUuOiktzvPcxHJMlLJz+PwTJiC
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a6da43-9e3c-474f-0dc9-08db81643397
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 16:39:16.4713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0l+/CD3ylW8KSTFgJXOwLu8QnOofiuTpdcFCCa8MGTojNjrfnsSP1VH8daplGm6X7qmLXej7t8OYM23LFM66fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5376
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_12,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307100150
X-Proofpoint-ORIG-GUID: ka_76WydXt7lT-mN4s2IzD_IM9JIsSjH
X-Proofpoint-GUID: ka_76WydXt7lT-mN4s2IzD_IM9JIsSjH
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 10, 2023, at 12:36 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2023-07-10 at 15:55 +0000, Chuck Lever III wrote:
>>=20
>>> On Jul 10, 2023, at 11:33 AM, Lorenzo Bianconi <lorenzo@kernel.org> wro=
te:
>>>=20
>>>>> + for (i =3D 0; i < serv->sv_nrpools; i++) {
>>>>> + struct svc_rqst *rqstp;
>>>>> +
>>>>> + seq_puts(m, "XID        | FLAGS      | PROG       |");
>>>>> + seq_puts(m, " VERS       | PROC\t|");
>>>>> + seq_puts(m, " REMOTE - LOCAL IP ADDR");
>>>>> + seq_puts(m, "\t\t\t\t\t\t\t\t   | NFS4 COMPOUND OPS\n");
>>>>> + list_for_each_entry_rcu(rqstp,
>>>>> + &serv->sv_pools[i].sp_all_threads,
>>>>> + rq_all) {
>>>>> + if (!test_bit(RQ_BUSY, &rqstp->rq_flags))
>>>>> + continue;
>>>>> +
>>>>> + seq_printf(m,
>>>>> +    "0x%08x | 0x%08lx | 0x%08x | NFSv%d      | %s\t|",
>>>>> +    be32_to_cpu(rqstp->rq_xid), rqstp->rq_flags,
>>>>> +    rqstp->rq_prog, rqstp->rq_vers,
>>>>> +    svc_proc_name(rqstp));
>>>>> +
>>>>> + if (rqstp->rq_addr.ss_family =3D=3D AF_INET) {
>>>>> + seq_printf(m, " %pI4 - %pI4\t\t\t\t\t\t\t   |",
>>>>> +    &((struct sockaddr_in *)&rqstp->rq_addr)->sin_addr,
>>>>> +    &((struct sockaddr_in *)&rqstp->rq_daddr)->sin_addr);
>>>>> + } else if (rqstp->rq_addr.ss_family =3D=3D AF_INET6) {
>>>>> + seq_printf(m, " %pI6 - %pI6 |",
>>>>> +    &((struct sockaddr_in6 *)&rqstp->rq_addr)->sin6_addr,
>>>>> +    &((struct sockaddr_in6 *)&rqstp->rq_daddr)->sin6_addr);
>>>>> + } else {
>>>>> + seq_printf(m, " Unknown address family: %hu\n",
>>>>> +    rqstp->rq_addr.ss_family);
>>>>> + continue;
>>>>> + }
>>>>> +#ifdef CONFIG_NFSD_V4
>>>>> + if (rqstp->rq_vers =3D=3D NFS4_VERSION &&
>>>>> +     rqstp->rq_proc =3D=3D NFSPROC4_COMPOUND) {
>>>>> + /* NFSv4 compund */
>>>>> + struct nfsd4_compoundargs *args =3D rqstp->rq_argp;
>>>>> + struct nfsd4_compoundres *resp =3D rqstp->rq_resp;
>>>>> +
>>>>> + while (resp->opcnt < args->opcnt) {
>>>>> + struct nfsd4_op *op =3D &args->ops[resp->opcnt++];
>>>>> +
>>>>> + seq_printf(m, " %s", nfsd4_op_name(op->opnum));
>>>>> + }
>>>>> + }
>>>>> +#endif /* CONFIG_NFSD_V4 */
>>>>> + seq_puts(m, "\n");
>>>>=20
>>>> My only quibble here is that the file format needs to be parsable
>>>> by scripts as well as readable by humans. I'm not sure I have a
>>>> specific comment, but it's something that needs some attention and
>>>> verification (with, say, a sample user space tool, hint hint).
>>>=20
>>> maybe we can add a csv hanlder, what do you think? not sure.
>>=20
>> I suggested JSON to Jeff as another option, but I don't think we want
>> to swing that far in the other direction.
>>=20
>> There are plenty of examples of /sys files that are both parsable and
>> human-friendly. I'll leave it to you to find one or two formats that
>> seem capable of the task at hand, and let's pick from one of those.
>>=20
>=20
> Are there already kernel libraries for this, or any examples of kernel
> interfaces that emit JSON? Most of the kernel interfaces I have
> experience with just use well-known fields delimited by spaces.

As I said, I don't think we need to go with a heavily structured
format. JSON was just "yet another crazy idea."

Other /sys files seem to strike a sensible balance, so let's research
what's already in use first.


--
Chuck Lever


