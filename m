Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD305571BA9
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Jul 2022 15:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbiGLNqx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Jul 2022 09:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbiGLNqr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Jul 2022 09:46:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275A9B7D5D;
        Tue, 12 Jul 2022 06:46:47 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CCtXQg022368;
        Tue, 12 Jul 2022 13:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Opu34hHQMPSvPlv3whVoimG8J3VxO5st1Dp83FWfUBs=;
 b=rMmR1quGZOnXu2zni+Ewo6fl1LvpJGTywM9plkx6+Vfwl6ssFkzGHH34ozdJXqHD521Y
 +Q3dN4xiHIX7TYeElt/btH8g+lkZ82DHjFLjDAD2UkR2k47iJVUN8S9mSa3I/Nt+XvH5
 q0S4F9OE4mkaBkiryEJevj3/mOSiDQhgU6sD52aqxioHhlUQnPXInf9BRzMEWTfXLgp4
 EjIxyeLI/e2UF3Gsm4wvca52RkhPpwCrPUQLmVFfk5PsNfDs32tLVCRW3F7jcTHnM9IR
 RMSkBnwvXhlI/AN1UtXLDcSeaoskTm9lW2gcWqsnOgyeFNjT6AeWmdq2UKGsIJsSLX1g Ng== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h727sexfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 13:46:36 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26CDfYv9016544;
        Tue, 12 Jul 2022 13:46:36 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7043ppdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 13:46:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkderzQlyM4nm6vSQrfjMZ/W+zWYkQTyh7P+TfEKca59r0jwQZZQLkKOAwTL9AZikONiBTI4vWNf41e4f97BrnQDMGCLZrMhTpoHcMFo93VXpfG+S1iW6VPTDXBmp5fIiseYu2CfsPpidow9pycVLhCM7WDPNnmkHw6d6WnpeoMi5h8lkEXlGxWBZc1CSBMFKHl/J6xakHne7DFWPRGg6grDSLRqbSTqA+3xzEJTUszy4pqigIS6UBzbYPScmzo+52OCeLRntqVaGA/6JzUH7KQziomhJmwczk7s5C2wO43ljevxCD2BcK5qqVXnMDGGLubfrZMqZl2Gjky0r4n1JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Opu34hHQMPSvPlv3whVoimG8J3VxO5st1Dp83FWfUBs=;
 b=ix+RKbk8qmzVnUiJOzep6ZXngTJXh40bd4oFqWnitqJxEPaA8y3YFRwq8F5IXgr/3jrT9Ss0kw04IBV7mY7b9f5MZDxC0hPOAezGSKWQS4u7iWtKzsq/cU5X3vsRzxwNsvav3dgPX/K7wqSpKA2icrR2VXBQtneKXOGjI4JA4Mw3NrypQxup6tCrLTYUiJ5VySsslHV+q4Ax4e7dejiQ26jEaeR/cvDFiErzvYgN40JN6huOsSbzUC4bj642prtFo7YvMBLoGwa1gtafii4nibTbzLpv8CbNg+SuVRIzfJh+4P9eUGujWen52jQfNMX2Xq8nuIdClmdeV3DZDoIz5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Opu34hHQMPSvPlv3whVoimG8J3VxO5st1Dp83FWfUBs=;
 b=fBRruRzCtlwgTxuWq0p9n3w82hpxsLqrtQsZc4ZskvnyLX1y0mH9tzSKoX+Z4TkWQaDYPP6bScNKVidyLOILMiW38bfqmDTggvuy5MCGUk8ba6PBWtNxxhHsDYyozyqVPeAjzT+2Qb3DBTia/lS78FJTAloXZfjRpwVmlgFQ8oE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM5PR1001MB2250.namprd10.prod.outlook.com (2603:10b6:4:2b::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21; Tue, 12 Jul
 2022 13:46:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 13:46:33 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Igor Mammedov <imammedo@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] NFSD: Decode NFSv4 birth time attribute
Thread-Topic: [PATCH v1] NFSD: Decode NFSv4 birth time attribute
Thread-Index: AQHYlI1Yu1IMkeKgwEG1/w/Jb2AUD615alaAgAABEoCAAPjFAIAAXk8A
Date:   Tue, 12 Jul 2022 13:46:33 +0000
Message-ID: <78752B5D-7D24-4856-A368-5C4633CDF491@oracle.com>
References: <165747876458.1259.8334435718280903102.stgit@bazille.1015granger.net>
 <20220711191447.1046538c@redhat.com>
 <A4F0C111-B2EB-4325-AC6A-4A80BD19DA43@oracle.com>
 <20220712100900.1c8b18dc@redhat.com>
In-Reply-To: <20220712100900.1c8b18dc@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87141f43-063f-450b-e0e0-08da640ceec2
x-ms-traffictypediagnostic: DM5PR1001MB2250:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nylahQMpxz2KYUi5kV5NrmkyB9qAS5Bbub3SOC78hgGnLVnoGokI50pWfH8BdxnWLcON+8dK/NiqjD+6475Bo4DMS8TKVSdxkWOR1606t3Dp31DNzE6Hqg8W30x+lz9yCAHU1uxQrv+AUW36yuhdhMFvT8KK+gCt00kISP8HHn/u8BeVmuhw1Z991yVd5M2BeDjjkydsoVDtLYm3E8L9+UmL+HSz7rlASoHCxNx1zDePiuI3wBjSsvz5vxy0DiT/gMbvNlLuGrM0ENeDzMBTvWg+mBZ3YkKairyvOcEo80QeFWo5akkQ6/Z8PkWHv6ZQUaAthAh5cCQGCwo6B5vjqa4MxqxGV7Oub3VaF7Xql2IlklpjIGerwsN2viR/Gh/o2/RFAtwLisXHHciAKDF5oNd1LWGR/mW/m5sjzly+JPCLF5cTnr6yqPT5pGE9lbeal+wvyBcMasOWSeskJz47DF7W0vhmovLOhL91iZdvpu50/KrcYt6SeEZErRZz5d1Cc/FqGkuXRp+eUSj7Hr2QHpqkzAQokzsrnXEikH2pgWaw6kDcHPxxPTcs/DULuE/k6y4MRFJ/y9XPVnH4vVD270rmANI6aviW80GDRQj6ub5rAA7HCdkb6vXLflVlW3n8s9yz5dJ6oU86X1DaqBIBVLKkMTnkwY757wq7f6j/oRVqTxWSwG/sdKCDxW2Vyeo8ou0sP6k5WT5cmC5yfeP1P0k7HT/9aWnYKxG94RrxUsJC4bucLIS7xAGG+2Lu92eLxLPpwpH4z0kLj8LIDC5TwEnqNFBfmU14uV0vE2GRbilELuClSOingtVEf++sHXTx6Q94w4raRC1+0/GwIMMlnA9+XnPNIdamdVdB+1XAm6s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(366004)(376002)(136003)(346002)(66556008)(91956017)(64756008)(83380400001)(122000001)(66476007)(8676002)(76116006)(66446008)(66946007)(38100700002)(8936002)(186003)(2616005)(86362001)(4326008)(2906002)(5660300002)(6486002)(6506007)(53546011)(6916009)(54906003)(316002)(41300700001)(26005)(33656002)(6512007)(36756003)(38070700005)(478600001)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?va9hW+uC3I9TZTkRdwFFmjZjPWlcX9+TGULE/h3yqFofARumx76G8/UfV7Y5?=
 =?us-ascii?Q?uUh3rDvChKf7OvgogrjVuxIA6+Rrk0Wzc4K6B/jVrATs8hjJHCN/KSrZwGrL?=
 =?us-ascii?Q?KXVs6vpnwOp403rFiD69WDh7deAggIkwvS/6o3gb86U05cBE4DWmlLb69DJp?=
 =?us-ascii?Q?EO9GrLkURKuzx2ePsI0PdcRhsrrq8v6Fvz8LyegIqwuVbn11oL0ztOGmMB6c?=
 =?us-ascii?Q?YO9u5G+1CELruNmSU4QALhy05W+5TE1J7N+ft7R45VJVTTrjaXwHeZWcIuIR?=
 =?us-ascii?Q?08QANN9YhugbrMTc/to679h7Q4OrVbrACadyyiYfX91KK8XfCmTZC2EoSTfc?=
 =?us-ascii?Q?wfiYPB0hapUqtqWE9SOU/eFQ6udOHPPXeyISS8Acnxdj9yYHHwYDM+6N0slU?=
 =?us-ascii?Q?afFtcqAg1ef+QwVUZLU1OnnP448CT2AGDy/WccPVaxEnJ7M6zPlV9gI4kukP?=
 =?us-ascii?Q?EQat/0hGMtTWSYPMdR1CuWOQOwrXeQaGHrutt9NTE+yN1zey49MzXwwDt84P?=
 =?us-ascii?Q?Woi15TQICuGJ+bEL6/KjRF/V7Jc5JqHYLOGdYMNTg3a52jYXe+c95Nykrjjq?=
 =?us-ascii?Q?4KEVEiWMDEZnYFMrWuPF3bgSGdWmp1V1ORcKnY5Z6dufiW/zDSYdE7/uGnRu?=
 =?us-ascii?Q?CBP5OuLjYjQ+QofDFXlFdP/x3uJu2B6SIjArY7axdSYz2psQ0cAZKyDW4HAI?=
 =?us-ascii?Q?7ekXNNFxRsfJR8U6qSJqggnca8Uyyr1RbRiDRIFjcMFMZolPaf3WZx9su2md?=
 =?us-ascii?Q?umq6yv0dJI2p0rFOq5O5YJe+wPDH8aQoXAJOUVoSc6FT6qmW/odBgHpxQRXp?=
 =?us-ascii?Q?tQOEmg5O66ZyHf0N4iCqJCO9iyxomr7RllrPaA4uMi8d6g+eQc7Vi7Kx9VBy?=
 =?us-ascii?Q?3ZXhmVXueNllJ0Cc5vox10oW0Ij1ki3itsY2c643pxQw8eDJeujk1kxW2PfO?=
 =?us-ascii?Q?6EPO8dVVqceTLWxbnwWN9B7Yosup9aGR0fS5gtddQpWC3EXS2XBeGkOYp2YI?=
 =?us-ascii?Q?PcYSKJbVUWl6z0ybCIoG+Iavvr/3BKb10oan9t6T4fBM16quuGo8VErfAZLZ?=
 =?us-ascii?Q?KmKGCN1O59V3AyZ/ONAyVDmfimRVKLHfOa+7jqlyAtZ+B1Dwn2GrjvUekKAj?=
 =?us-ascii?Q?BJfpHaw+kTU58T+r3d8eFz7Im8CSPKEFis9Mm3JTrpMN/0zhWTZ3DoblqbzF?=
 =?us-ascii?Q?dF+8loGQXqyhmaI6WmCLeW9A3Qj7Z0D2X641z1oFnF0zjUdmzQeMhLeiKYsh?=
 =?us-ascii?Q?uCO+ZQygjug51vgeRBj1c6faVskrxiZU7Y9Q2Yv/6RaLUH7GVqEvHZh3N+0o?=
 =?us-ascii?Q?LzWIzG/0eOAHliQ7fuezUI3Rz6GlElORfk8jXkhNcC47z8URlqmOd7sfrX3W?=
 =?us-ascii?Q?xmE05Xlw27hf5dk0p8IXBFQhWLO42bmzm0Ff+E6IhExugLXyf7y8tT3zVZPA?=
 =?us-ascii?Q?YehNa1aoLCf6kq1JNAnKsCPWTF0l+pEG8Z6MSUM0yFZWl7eZTQRm3fcaErIU?=
 =?us-ascii?Q?2GoOEd6hRFrbSrvh+9Sn/iHWsv2osqtbMJJZwjEzzjbDX3qRgqyo90g/Q9Fb?=
 =?us-ascii?Q?LCHLXklmSTQ428o8tRC8QadEmzY6/XBwed2tEo92TBNYgh+aVEv9nG5jXfxo?=
 =?us-ascii?Q?kg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BE52C2471B4AFA4281AAA1532B27A021@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87141f43-063f-450b-e0e0-08da640ceec2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 13:46:33.4168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QXCQd5haAxGE/aBwMjQdwE3RVW7WAYfKqeYXn5yNWSHofW8TqtrhjUssTPHJUj+fMHoK7xrQNypb/zSh9fGXsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2250
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_08:2022-07-12,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207120053
X-Proofpoint-ORIG-GUID: GxNsgIHY6CxtKRXMhqTerQyiR3-0lLTI
X-Proofpoint-GUID: GxNsgIHY6CxtKRXMhqTerQyiR3-0lLTI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Jul 12, 2022, at 4:09 AM, Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> On Mon, 11 Jul 2022 17:18:38 +0000
> Chuck Lever III <chuck.lever@oracle.com> wrote:
>=20
>>> On Jul 11, 2022, at 1:14 PM, Igor Mammedov <imammedo@redhat.com> wrote:
>>>=20
>>> on tangent:
>>> when copying file from Mac (used 'cp') there is a delay ~4sec/file
>>> 'cp' does first triggers create then extra open and then setattr
>>> which returns
>>> SETATTR Status: NFS4ERR_DELAY
>>> after which the client stalls for a few seconds before repeating setatt=
r.
>>> So question is what makes server unhappy to trigger this error
>>> and if it could be fixed on server side.
>>>=20
>>> it seems to affect other methods of copying. So if one extracted
>>> an archive with multiple files or copied multiple files, that
>>> would be a pain.
>>>=20
>>> With vers=3D3 copying is 'instant'
>>> with linux client and vers=3D4.0 copying is 'instant' as well but it
>>> doesn't use the same call sequence.
>>>=20
>>> PS:
>>> it is not regression (I think slowness was there for a long time)=20
>>=20
>> A network capture would help diagnose this further, but it
>> sounds like it's delegation-related.
> yep, there was delegation request/response right after SETATTR failure
> possibly prompted by NFS4ERR_DELAY
>=20
> shall I provide a network capture (I guess pcap file) from test env
> I have?

Yes, you can send it directly to me.


--
Chuck Lever



