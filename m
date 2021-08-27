Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276663FA1ED
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Aug 2021 01:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbhH0Xut (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Aug 2021 19:50:49 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:8682 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232546AbhH0Xuo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Aug 2021 19:50:44 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17RMoia7031580;
        Fri, 27 Aug 2021 23:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=YMvaFbP74oUY/FhhCu9bApzEIN3LqnA1hExQ3iw+3x0=;
 b=vdhA1nCIifXow95w8hxpfpee3FIb/efDO5Xh7Tl280IksfJAnEq+/oGXDnqvAwdHDETf
 6hkO1J4y2+C68ApRtB+3AXkS9HZV3B1sRfmXShmwJVPzswhwKN+BNZ/cRg36EdIT9JtZ
 mzchztD8HF/JMluzZ8e3T32JP/L1dBL7e928XEVR+GSLH9tMLR6CwvJ9+VBrrReqKS3A
 qP6DYQJsyJrwqi9MakaLiJBgN/Fmk7zl4JcaCSOHz5XQ3336sZR+XrbkcWzll2yEkcPW
 /LjkduiA0xl24T8E0NUUuT5VE+L4SXUPGBtJ7+YuiIba0qnbdZRC4nPlvmQ4t99KnNPy 0w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=YMvaFbP74oUY/FhhCu9bApzEIN3LqnA1hExQ3iw+3x0=;
 b=IizTekEUS9NUf5dj1aNc5FsnXSyM58DHyCCg78DoersvSJUoj9GxKFLPTfPW8ah02BKc
 t/OlfiWysAvi3cl4zxFlMC1dZD6mR7ChaNKReHl0RsFJaiXGtU37M5SurgzoX8BY65KR
 QCgS5Fsb8Tx4FZSsSsTVNygvgYVOQD3sSjrjhgLOt6O0RTdvSre49p9BE9vtz+p2Qx/g
 Na2+Boai8Z/+XVR8lS88CncDNgsBVivWm/afoRxz+UgsSNJOtDMEEWKLRvDvgJ06EAZv
 9TQaUUfCxnNJ7SUIPE5U9PyZd6HEu2KQNV3crkKla73R2QnXCBF1ycUBxyd7ewuRcNTf Nw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aq970g1jf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 23:49:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17RNjPfa192187;
        Fri, 27 Aug 2021 23:49:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by aserp3020.oracle.com with ESMTP id 3aq5yya54t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 23:49:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TyfJQb79FRsfFFzJfJUz4ZRpBxo34iR82RGwFLbYVspBMBe3fhXxiDtzP5FdIIr953DbqjbKiuHw13O80BCoaAQdcGsUi5Zqj0dqRHN9vix+UhvZ0AqlYHbYpX/nMx9cS0OAl+czVqJTKysXXLyTLi9Uae/rvK6n3J5FEAytW/xI2/2qFZir3FTjmQO4m1ltX2CWv4ur4qAO7x1cM1ShEVtdvV704qc4raNj3ZXBYsS/4podLXOAKx63xeI/wb9/t3HVq9gV+PgebVr48/MBgz0MnFC0BTmJAZatE5Z5rEYC5H23Qnx9EIdxTm3xtMQgjaH+PZI5UpTxHX6quuk2Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMvaFbP74oUY/FhhCu9bApzEIN3LqnA1hExQ3iw+3x0=;
 b=BmxOEdfM6iQQWC2fvWH2hw4RbiKd+twWjjnLaoVXsehQu3XneC1wZtaomVa1pbsI5g2scZzBisuJmR7BOvpNsmoeO58U7JcWPJIO/W9UrTBuIaR48LblGOzIKudM0BF1LwMSemz+4XNEUqHcXh9Ss7nLwra32PyCT/A2fHGeSFboxe4/KEgPPViLF861fJr5XzY6e3dNG9ppIv/IIfpMQZCCtvfGkIg4y1wcP3/5HFQwUMHGbHdiK37iD4CaoeOD+AWBh1OjR/WNX87pQIHV0I5FZfwuZYMa3FEAv0KqkILfO7aoRuhe9DLa+40CTzx3C/rR801lX+lfJIWN9pgJ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMvaFbP74oUY/FhhCu9bApzEIN3LqnA1hExQ3iw+3x0=;
 b=U+x6P1bKDzd1eJabnnXVjldJT6XBdnEgBLkVE01kEitsUOHVsSpNrrGWbi7b7BvmS+oJH8R64ThI3vDJDYcqfMsyB/dB7s49P0FXMfB+/aVKIzpqT4b7C3n8D36d9wJoEv8Jlykz9ogjr7qDF+qE0q6LeROGnX/yzRbO2IPTItI=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4385.namprd10.prod.outlook.com (2603:10b6:a03:20a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Fri, 27 Aug
 2021 23:49:47 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%5]) with mapi id 15.20.4457.021; Fri, 27 Aug 2021
 23:49:46 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Mike Javorski <mike.javorski@gmail.com>
CC:     Neil Brown <neilb@suse.de>, Mel Gorman <mgorman@suse.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
Thread-Topic: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
Thread-Index: AQHXjKYRxKTFwD0+C02+ZMVduTdsB6tqSi4AgAAHiwCAAZhPAIAACtMAgAS9YICAAA1rAIAAA7UAgAMLuwCAAZFegIAAyYQAgAAzUQCAAG7RAIAE0AAAgAAF0YCAAxscgIAAOP4AgAAGqYCAASxAgIAGIIuAgAAkXICAACgEAIAAWTeAgAAMTwCAABHBgIAAdRaAgAAwjgCAAFHqgIAAHnMA
Date:   Fri, 27 Aug 2021 23:49:46 +0000
Message-ID: <416268C9-BEAC-483C-9392-8139340BC849@oracle.com>
References: <CAOv1SKCmdtchm5Z2NU80o49tkrHpAkPFaHKj4-vLDN5bZNCz-Q@mail.gmail.com>
 <162846730406.22632.14734595494457390936@noble.neil.brown.name>
 <CAOv1SKBZ7sGBnvG9-M+De+s=CfU=H_GBs4hJah1E4ks+NSMyPw@mail.gmail.com>
 <CAOv1SKCUM5cGuXWAc7dsXtbmPMATqd245juC+S9gVXHWiZsvmQ@mail.gmail.com>
 <162855893202.12431.3423894387218130632@noble.neil.brown.name>
 <CAOv1SKAaSbfw53LWCCrvGCHESgdtCf5h275Zkzi9_uHkqnCrdg@mail.gmail.com>
 <162882238416.1695.4958036322575947783@noble.neil.brown.name>
 <CAOv1SKB_dsam7P9pzzh_SKCtA8uE9cyFdJ=qquEfhLT42-szPA@mail.gmail.com>
 <CAOv1SKDDOj5UeUwztrMSNJnLgSoEgD8OU55hqtLHffHvaCQzzA@mail.gmail.com>
 <162907681945.1695.10796003189432247877@noble.neil.brown.name>
 <87777C39-BDDA-4E1E-83FA-5B46918A66D3@oracle.com>
 <CAOv1SKA5ByO7PYQwvd6iBcPieWxEp=BfUZuigJ=7Hm4HAmTuMA@mail.gmail.com>
 <162915491276.9892.7049267765583701172@noble.neil.brown.name>
 <162941948235.9892.6790956894845282568@noble.neil.brown.name>
 <CAOv1SKAyr0Cixc8eQf8-Fdnf=9Db_xZGsweq9K2E5AkALFqavQ@mail.gmail.com>
 <CAOv1SKDDUFpgexZ_xYCe6c2-UCBK0+vicoG+LAtG2Zhispd_jg@mail.gmail.com>
 <162960371884.9892.13803244995043191094@noble.neil.brown.name>
 <CAOv1SKBePD6N-R0uETgcSPA-LZZ4895ZJDKTY7mYvhfu184OQQ@mail.gmail.com>
 <162966962721.9892.5962616727949224286@noble.neil.brown.name>
 <CAOv1SKB6xqyduf5L5hcXOe-xMN-UJOfFeE5eXVga3TviKuH0PA@mail.gmail.com>
 <163001427749.7591.7281634750945934559@noble.neil.brown.name>
 <CAOv1SKC+3LXhM+L9MwU2D03bpeof55-g+i=r3SWEjVWcPVCi8Q@mail.gmail.com>
 <163004202961.7591.12633163545286005205@noble.neil.brown.name>
 <CAOv1SKDTcg5WDp5zf3ZGL0enJ7K693W-9TMYKcrgweyzp6Qjhg@mail.gmail.com>
 <163004848514.7591.2757618782251492498@noble.neil.brown.name>
 <6CC9C852-CEE3-4657-86AD-9D5759E2BE1C@oracle.com>
 <CAOv1SKAiPB62sQcnDCKC5vYbbmakfbe80KRu3JEVZVO7Trk8cw@mail.gmail.com>
 <CAOv1SKATk1iP=J9r2x0CQzNuwq2VoRvN8Mkba3DsKq6W_tfrDQ@mail.gmail.com>
In-Reply-To: <CAOv1SKATk1iP=J9r2x0CQzNuwq2VoRvN8Mkba3DsKq6W_tfrDQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08234c16-96d5-483c-a3cd-08d969b55a05
x-ms-traffictypediagnostic: BY5PR10MB4385:
x-microsoft-antispam-prvs: <BY5PR10MB43853311815EF0A9DD7A335F93C89@BY5PR10MB4385.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uNE9rzWttDLbZzeS6Y5hpLhKL549sK3x2D569iOK1RrAwYqx4nq8qAasYV/GwPR+u5y8ERvC4d6hKtg9uyB9Uxx9jXH2t5EsIWOVF/hsW/4bIjNxf3K+BpG/iE8HdBWcpCpQrzCkCT+tGajxUvPpgKMxPouEqwsSCP01yv0Ha9FMUguLCBKKIDrwzzMjPUVmZcwc+DfW2Jor6a4sa9aIENanyOowzI+DMXbTg7uDt9cHOmzm80jOXe6NJ2MBrYmX3qk4ryMwXVQzXjpoRVnb0dZIzW4OvOQLnMWqllI0fv0Akwp4gcMqecIqq5k2456WyXF/L0fbprsCCINrTy8dE2WGz0qah7dhcCiihbHrUsVq/ZcUKlM0xZrMSRn4Qf72wW4F6W721loBM2Zm0A/jiHVf6yDh9o2fDi7oaqVgpOfXBv3U1fSGLMCh2S0cY/VLtLRuPDtTEM6BpxhnfcNT4p5KxiEKi5+Q1ZpL2wPuAWSsC24L9M3VTckakV+E1yLh2QOEQrTCvhkX2g4OMDnvnNz8YBTBgz0BzI/MOxydadvADCbsTOdrKyKy4vHt2JJC5XyvhIEHpNurrWErsYPkisEnCqZyptRmGkZULksUbtLjvxJOgOg1N7jMzQdafuX5asufxnEGsmtzWag4aYBHz1X1IzmX6SBqn0m4CaBNThbniTUoU0kbwnwXKDq786iO6amFe0Fpw7y8Dpp/vOPnc4kxodZq33elTD9xYHs41Ps9OqyudnVFoOryNm+SYI9A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(53546011)(66556008)(91956017)(64756008)(6486002)(26005)(76116006)(66946007)(36756003)(8676002)(6512007)(83380400001)(6506007)(5660300002)(508600001)(2906002)(186003)(2616005)(66446008)(8936002)(33656002)(38070700005)(38100700002)(4326008)(54906003)(66476007)(86362001)(316002)(122000001)(71200400001)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JMwomIoIP6k2rpDCxgOlhoCns+8ZRtV34yBEsDsZZfjHOXklZ8uiZ/53Hokp?=
 =?us-ascii?Q?CDC3+mfvklmUylXuss9+Vjsz0ajK23NWKR3gsp6LhlBEsA3cClUTmZy14NOk?=
 =?us-ascii?Q?wMeTQdRGy8WGiUL8TnypBevvYTptNnG7PQ129GlpqDyqg+mbHGEu01w9Zu7S?=
 =?us-ascii?Q?2SyeUMmhZzAUMgYQacAkrmbQAHibmOHByEDpB7ADSNtg4TdVHLSBuS/sUeH6?=
 =?us-ascii?Q?yL+FcurCL/nMu38RmVNKgGRaU1/DouDkVtQH9mcdQfPWfqgSYiaPBqUTu7vx?=
 =?us-ascii?Q?frqRS0nHnslBzHCJxGw7RW5+L603Yn8RylJ36lCaDD3eIBDzX8xl9EGRTiBG?=
 =?us-ascii?Q?kNpLStDedRlIMF+0NGSyx0aDIn5MZDN2fZ2xJBIx1MSvBNLhd9Y+EeoHGap8?=
 =?us-ascii?Q?/qp10WGZdxHkUr+167x7eDFWZPRH9SIT31DMuCG5on5MuncMZJiUXk0Az/UC?=
 =?us-ascii?Q?6DIZZjrcu+W22hVkum4Rkxhvny7CvMBn7oDsbMi4iXqW8SnO0t+xgvLMrxxS?=
 =?us-ascii?Q?Wan1j3A830A0aPnY66gUSW3fs+Snp8lTVqLxLQhO9dCMfHRWAj5hzyU/Mxub?=
 =?us-ascii?Q?lRdIy9XIhc6cQozQLXwMDuZUSy+rpIsO0rySYfGtEptw+qudkKlNbdA6GIXN?=
 =?us-ascii?Q?YoiStglCRt/z8NawE4dOJ9on/tKhgi7q9FgJ3Iewf6pGdFaWMfBORdhamkSA?=
 =?us-ascii?Q?+xta/KBG5bEoLgAAwx2sOSPG+keU6TRtpJFd3GMEZ5NgT64Sr+Ub3saLACSk?=
 =?us-ascii?Q?kQbx/DRPa3mHxzHSByM5KN8ToXt0iR3w/1iyymvBIX7g6Z54fJpZ1YOvVXgx?=
 =?us-ascii?Q?pP7WX5c2r/UASK5BaIpDaTI5o6oSq1/z0THGTGGUL6r/pTvZbPNHddkI1K3H?=
 =?us-ascii?Q?Ll1579W/BS/LT8e4Q3w/1pA2UKYRAgHbQOUYdX08byGpVqhCqptA4C7Nj9Jr?=
 =?us-ascii?Q?QRSpjBf6h5/Z8g707TKXKc4sT1mTBx7k9FkbneiSt4YQx2QTcB7UzQ+C8Gwq?=
 =?us-ascii?Q?L0kx+q9TZQ2p89rYR5nN5VEexuZQq9fFMNtr2W4DGYJ0md7ZQoDfq9w+ghJ5?=
 =?us-ascii?Q?bUbVzeGWAWO+XwTEMhjz6DLYGILOj8OfKBpI8Tsu6YtBu09j+39sjIIxtm10?=
 =?us-ascii?Q?A9xogv9CXE8DFcfF3/zTF3vywR4YDmmcne1C2mdibKLi8a61obURMx8+6+IE?=
 =?us-ascii?Q?Elx0obdYcGZsV/WtuafvEGmsffkJcs5gdM42eCrToQOcfGTtUd+0pFfLNsvY?=
 =?us-ascii?Q?NLWGFq+Pohz+T/FiOuVbxp7/dJIvwFRbFGGh1kCaX4YQea1byn6jIfhWETw9?=
 =?us-ascii?Q?4/W4ICWlndZ9LCYfkXrV+maw?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9274FF6C9CD94842A89AB77122F733FA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08234c16-96d5-483c-a3cd-08d969b55a05
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2021 23:49:46.9085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: voZVidbAxlz7ykS62Q2+n9bibh7oojwA1zltCYcj9wMvIdzURbhz3XAHMyENZKosj0VNi2vEZKckC79XmFnQ7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4385
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10089 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108270141
X-Proofpoint-GUID: eWtQRMFgd9Gux46_elRw_Z5ZgBmPybQW
X-Proofpoint-ORIG-GUID: eWtQRMFgd9Gux46_elRw_Z5ZgBmPybQW
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Aug 27, 2021, at 6:00 PM, Mike Javorski <mike.javorski@gmail.com> wrot=
e:
>=20
> OK, an update. Several hours of spaced out testing sessions and the
> first patch seems to have resolved the issue. There may be a very tiny
> bit of lag that still occurs when opening/processing new files, but so
> far on this kernel I have not had any multi-second freezes. I am still
> waiting on the kernel with Neil's patch to compile (compiling on this
> underpowered server so it's taking several hours), but I think the
> testing there will just be to see if I can show it works still, and
> then to try and test in a memory constrained VM. To see if I can
> recreate Neil's experiment. Likely will have to do this over the
> weekend given the kernel compile delay + fiddling with a VM.

Thanks for your testing!


> Chuck: I don't mean to overstep bounds, but is it possible to get that
> patch pulled into 5.13 stable? That may help things for several people
> while 5.14 goes through it's shakedown in archlinux prior to release.

The patch had a Fixes: tag, so it should get automatically backported
to every kernel that has the broken commit. If you don't see it in
a subsequent 5.13 stable kernel, you are free to ask the stable
maintainers to consider it.


> - mike
>=20
> On Fri, Aug 27, 2021 at 10:07 AM Mike Javorski <mike.javorski@gmail.com> =
wrote:
>>=20
>> Chuck:
>> I just booted a 5.13.13 kernel with your suggested patch. No freezes
>> on the first test, but that sometimes happens so I will let the server
>> settle some and try it again later in the day (which also would align
>> with Neil's comment on memory fragmentation being a contributor).
>>=20
>> Neil:
>> I have started a compile with the above kernel + your patch to test
>> next unless you or Chuck determine that it isn't needed, or that I
>> should test both patches discreetly. As the above is already merged to
>> 5.14 it seemed logical to just add your patch on top.
>>=20
>> I will also try to set up a vm to test your md5sum scenario with the
>> various kernels since it's a much faster thing to test.
>>=20
>> - mike
>>=20
>> On Fri, Aug 27, 2021 at 7:13 AM Chuck Lever III <chuck.lever@oracle.com>=
 wrote:
>>>=20
>>>=20
>>>> On Aug 27, 2021, at 3:14 AM, NeilBrown <neilb@suse.de> wrote:
>>>>=20
>>>> Subject: [PATCH] SUNRPC: don't pause on incomplete allocation
>>>>=20
>>>> alloc_pages_bulk_array() attempts to allocate at least one page based =
on
>>>> the provided pages, and then opportunistically allocates more if that
>>>> can be done without dropping the spinlock.
>>>>=20
>>>> So if it returns fewer than requested, that could just mean that it
>>>> needed to drop the lock.  In that case, try again immediately.
>>>>=20
>>>> Only pause for a time if no progress could be made.
>>>=20
>>> The case I was worried about was "no pages available on the
>>> pcplist", in which case, alloc_pages_bulk_array() resorts
>>> to calling __alloc_pages() and returns only one new page.
>>>=20
>>> "No progess" would mean even __alloc_pages() failed.
>>>=20
>>> So this patch would behave essentially like the
>>> pre-alloc_pages_bulk_array() code: call alloc_page() for
>>> each empty struct_page in the array without pausing. That
>>> seems correct to me.
>>>=20
>>>=20
>>> I would add
>>>=20
>>> Fixes: f6e70aab9dfe ("SUNRPC: refresh rq_pages using a bulk page alloca=
tor")
>>>=20
>>>=20
>>>> Signed-off-by: NeilBrown <neilb@suse.de>
>>>> ---
>>>> net/sunrpc/svc_xprt.c | 7 +++++--
>>>> 1 file changed, 5 insertions(+), 2 deletions(-)
>>>>=20
>>>> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
>>>> index d66a8e44a1ae..99268dd95519 100644
>>>> --- a/net/sunrpc/svc_xprt.c
>>>> +++ b/net/sunrpc/svc_xprt.c
>>>> @@ -662,7 +662,7 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
>>>> {
>>>>      struct svc_serv *serv =3D rqstp->rq_server;
>>>>      struct xdr_buf *arg =3D &rqstp->rq_arg;
>>>> -     unsigned long pages, filled;
>>>> +     unsigned long pages, filled, prev;
>>>>=20
>>>>      pages =3D (serv->sv_max_mesg + 2 * PAGE_SIZE) >> PAGE_SHIFT;
>>>>      if (pages > RPCSVC_MAXPAGES) {
>>>> @@ -672,11 +672,14 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
>>>>              pages =3D RPCSVC_MAXPAGES;
>>>>      }
>>>>=20
>>>> -     for (;;) {
>>>> +     for (prev =3D 0;; prev =3D filled) {
>>>>              filled =3D alloc_pages_bulk_array(GFP_KERNEL, pages,
>>>>                                              rqstp->rq_pages);
>>>>              if (filled =3D=3D pages)
>>>>                      break;
>>>> +             if (filled > prev)
>>>> +                     /* Made progress, don't sleep yet */
>>>> +                     continue;
>>>>=20
>>>>              set_current_state(TASK_INTERRUPTIBLE);
>>>>              if (signalled() || kthread_should_stop()) {
>>>=20
>>> --
>>> Chuck Lever
>>>=20
>>>=20
>>>=20

--
Chuck Lever



