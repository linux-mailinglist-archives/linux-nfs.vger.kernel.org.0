Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA634400DC6
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Sep 2021 04:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbhIECEA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 4 Sep 2021 22:04:00 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:8730 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230185AbhIECD7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 4 Sep 2021 22:03:59 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 184F55Gh029952;
        Sun, 5 Sep 2021 02:02:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=AhWj7G1wpP82ozwguNApmfARN9bmbo43D3F4GYzV+wE=;
 b=OGM3mJQt8i44eNwKvop3TXRIcbfY9hUKS5mURXilWQz/7QReVDKluVEAKLt1Ig5a+mOA
 noAcEFjIoKMN7/oIeH9tF2vuidkxprUtTBSgnhvyXhTdjHkh5E9VRdRTf1MKiBpwD/nR
 00Xi6Q7gK2rDyVzLNEiy9C614iOw0hxQsAkO+Uf1L/pHJ3fgwdzYifxDSUEytlNR7BSV
 FzTBUh3W/Nw8NK5Act6dXjyjJDgAp96bmQVnSfKBgsxBqZoz6n59GOG4/yyemaMgAwh5
 c/di0BjT+ykYDy+ZIQCzidE5RWMQ+U3NalX5siFpC3ITiZA98W/pauoyKlr796XWdM3v ag== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=AhWj7G1wpP82ozwguNApmfARN9bmbo43D3F4GYzV+wE=;
 b=TaVl60nObEgla9Sq1xzzh1hT4qJYaPRR9b3tkwZyojpPhGXAWZR1pu3kFrw+SNrpSykl
 vUu843KADFn2KaFh/xlNEaWuTd0cIMa7JkVhQ8m0HaTfl47aC7F+j3ZVS3wd4ToNfC4a
 N2ZNqGnCGbjH7vapQawazvUxnhNVFFRi9UeYE5iAnaT57RYqERQ+ClmnuXcMhMlzj8US
 /2uiOi3deTBkXixif2sEXLyTq6Dc62sIpW3//YEZS7Ia+19fg1mf9YMHL7EutyVPN/AT
 b4hHywcpyq12wJAxOXQ76HK/DYp5P9Hv8PfmASQslaXdX6cxBkAVK8bcoZzEHifpOSl+ uA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3av0paskym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Sep 2021 02:02:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1851xriI013927;
        Sun, 5 Sep 2021 02:02:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by aserp3020.oracle.com with ESMTP id 3av0m1k78v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Sep 2021 02:02:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEG+hwQbutxkX5WgWegOUEmDoCx9TCj1F37klN8H8A4EijdxiqIcM5TsQpp+jG/7dviL5PcV1jFYiiPG7gen6QoCbiX2/3YFd0Zd4KunZ7O7V/ZEswrYCQ4lSfzp1q4FbWgxjly0EvPQ6I1whpLhs1W3/ZxBsmZQXOCMcosNdbV6mAa9SROm+9G9tbpYTJzMETcns+Ux58vYxq7gyBy65dV9fLE1I9wbnYcTDO5zS/TOuAL3QtdPtW65g8D38f9unQ4aXfQQjjbO9tOkuuz0UQ5EkKvnWKmiNB4FF7l6+l+RRVqU3uEv0ZbLZ0+H6U0ueEUcPFGXf0IF48bv87M1Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhWj7G1wpP82ozwguNApmfARN9bmbo43D3F4GYzV+wE=;
 b=H3FE4cUwjeiH2uRZK0QarlF8I7TW5XHt7hF8IfKvsNC+wHfbqIHJe+/zXkjZemWDkF5IMo5LlbIFPYr/0nWLeEFOVCq8vpvS2fXt8FAFgRQYIO8XfvJdHOTPfVjC3bNOUqRUEyA8zeYupwyzh0rJ8JWDGk7BrZjumkS8LgsLdIKlzIwx5D8ZPDCww8K35oVw44VGHERZmGbnHtI3rnCLbgxnL83EBQZqr58X17+VKPdgL1SCSE8BCezwRgYpcRoFVrWrXj0IQswkyE2zYZwovQjyeUF8dJGs1zWkL5kIZ8kI8BpqW61v/mjctYq645N6+QdH+IZE+UKhjbPhb7Ad+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhWj7G1wpP82ozwguNApmfARN9bmbo43D3F4GYzV+wE=;
 b=DopN5C4d62Xovx2P1ijppJDUXtcsxj05FTkvLgX5p9IpY8ZAxK6wiiqh2vUQHyHjZn/ZqGM4fe7AsL8UHVZLkfjT1JzZxto3f8nEfILDKDe3LWvBVvF1O3Uyv2q76rQ0yYV49LM2Wgb0Z7VI2fYrvNlA5uaDdCl8LdHuethRQLc=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4212.namprd10.prod.outlook.com (2603:10b6:a03:200::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Sun, 5 Sep
 2021 02:02:45 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%7]) with mapi id 15.20.4478.025; Sun, 5 Sep 2021
 02:02:45 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Mike Javorski <mike.javorski@gmail.com>
CC:     Mel Gorman <mgorman@suse.com>, Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
Thread-Topic: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
Thread-Index: AQHXjKYRxKTFwD0+C02+ZMVduTdsB6tqSi4AgAAHiwCAAZhPAIAACtMAgAS9YICAAA1rAIAAA7UAgAMLuwCAAZFegIAAyYQAgAAzUQCAAG7RAIAE0AAAgAAF0YCAAxscgIAAOP4AgAAGqYCAASxAgIAGIIuAgAAkXICAACgEAIAAWTeAgAAMTwCAABHBgIAAdRaAgAAwjgCAAFHqgIAAHnMAgAA7fACAAPuSAIAK9LQAgACMDXA=
Date:   Sun, 5 Sep 2021 02:02:45 +0000
Message-ID: <27DDAD3A-B9E0-4CD3-B997-E4AFBD8C5264@oracle.com>
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
 <416268C9-BEAC-483C-9392-8139340BC849@oracle.com>
 <CAOv1SKCjvgSfUoFtufZ5-dB-quG=djnn-UHO286S410aVxrV0Q@mail.gmail.com>
 <12B831AA-4A4E-4102-ADA3-97B6FA0B119E@oracle.com>
 <CAOv1SKC_ssgngiYMByVyngL6xUxPzbb7vKsvuwXjrAjC2TLcWA@mail.gmail.com>
In-Reply-To: <CAOv1SKC_ssgngiYMByVyngL6xUxPzbb7vKsvuwXjrAjC2TLcWA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb929574-1e2d-479d-97f9-08d9701140fd
x-ms-traffictypediagnostic: BY5PR10MB4212:
x-microsoft-antispam-prvs: <BY5PR10MB42128748FB714D516565FAD993D19@BY5PR10MB4212.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QETLKPnRnREku24NfbBIcJEyQP6kIvnlFpHZieRqcIyXWFPbsTNHu7CwFfQQIlA6MuPCNVp3pFnr68eCV1EQnVf9ILElxjL+qpf2GEtj1xxWYaOEUIQ8DLBS8W6ujf1S9RBju1/bUIg7+iDbaLTEQzsLUkkNZtOiF71R5f+H5Lys3fDbg+fg4xgG/2e3lAY+maUgJuDKhElrAxQ+pDom9k5dgYCCYfpwilQMFPHgj0DbquiDPkr26i8LWR9O77oNryPhXg31CfL4QbcW+i5LHJgrdcxGg88vC1KGyri8m0Ih1Fg4+30wzx5TdMrYT58a26k/30ybVfB+zPyt6lfo64HAU2Ma4xStg3yuWiwr7AoFOgMNh6UQDIRVbhRw0v8YhmowcIHG+3JigLp5or5pKF9FKnsO1npEekLyEvBx0seaGBPN6C81Zci1tNpgfvL0a1Q0esto5lf+x9TWV43Rc9umMRnSzKkv6bqwCqY9lXwsc3pU9lDjXmahUjjoUSKJe1b/PAddiHSGgg/ThyBGkWgTc10p6zNjtL8Qsnita7uuUv0ZIWMKUoXdoR5YC84NN7jAJXqqXIK+oZJTXZlLslGXha1hMQipOG/zTk8LcrIp5ajMVCyQb+tAPxtwKPh9fgAoixfo4n7b5RPFy4MknBQb4fFgyTZ3h2baNS5f+xSgLeG7wHzrl3Bh7PVyTW/eTZbM4MKGekNHN5qSxPjVpQY88lE8yOLzFWg3BmSoeuHQezPSmamZG+ItP7DIyRbl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(376002)(136003)(39860400002)(2616005)(71200400001)(8676002)(38100700002)(6512007)(4326008)(6486002)(91956017)(66476007)(122000001)(86362001)(83380400001)(53546011)(76116006)(6506007)(5660300002)(8936002)(36756003)(64756008)(66446008)(6916009)(2906002)(26005)(186003)(54906003)(316002)(38070700005)(478600001)(66556008)(66946007)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2NsQ2xWeWZFNTdTZW4wRlR2Ly8rdWVQM3JuZ0dBL0xqcUZrSlFnTnRoZHNZ?=
 =?utf-8?B?eHM4ZTdBK21ZSS9lYjVuNEJ1eEE0VytPY085ZzhiVTdBejZKYzh4VzlpU1hO?=
 =?utf-8?B?eFdEMVBwQU9Qby9GSDNLNDM1aEVvY3d6L1JLdy94dS9sanZPcjl6QVVtS3dz?=
 =?utf-8?B?WFlZUkE5QzY3L0N6KzNrYjlGcXp6dWUvM3VESE1ETTROTU1uMnNmSHkxOXZh?=
 =?utf-8?B?M1Z6OXF0L2hUTDNhakVlMzNJWEoxelYyWjJPMzZkbHQwd2NGZjZrTHE3TFFI?=
 =?utf-8?B?cWtkQXduNGRBUmlVUUp1RjhxZStYWGdIWVJyUXRiT21uT1M5L3BKeCtKeWFy?=
 =?utf-8?B?L2cxY3MvSE90MmVxUzZkcXpBQS9nL3NxK2tCdjBEOTJZR21TNmJEcnlZamdl?=
 =?utf-8?B?cjhtRG4xZWVtSk1uR3dvRGxtQmM1MWRyRFBkVlBUTEVFVWpTTGNGcnh5SlJs?=
 =?utf-8?B?VTM1dUIxMXprenMvV2U0VzJuYTYxRzRldFY1cFVwcS9pNzhBVlViU0JVMzZN?=
 =?utf-8?B?STZMNXJ0QVhSWXVEQmtWRGF6L1ZrdkdpMGFoMUlrT0dnUng1R2gxNVFQd1dq?=
 =?utf-8?B?Y3RoeXVjS1NKamtpR0k0RlF1MzVIYjFzU2Jpd0JJWXkwckVSZTV1ZENkQ052?=
 =?utf-8?B?RTBDU0cyU3FQeHdrVW9jTnhqNjlQU0k4WEtPRUpBbm5wcEszUnBQUi9kayt5?=
 =?utf-8?B?Wkhua1pwOTV5aDJvVEFVWTZublZWVWR5RENJM1F0RzZOV1F5LzFSV1Mxa3RT?=
 =?utf-8?B?SlROcW5qL25MYy9aTXgvZXFkVEVNRGdwM2dZMlQwdTk0cGtIWE5LS2NtWGVL?=
 =?utf-8?B?KzJCcVNZQWxTc3RPbmpyQkIrU0p1NWZ6enJsQm5NMzl2K3NmNHI2dEZ5YnZG?=
 =?utf-8?B?aW1PL3N5VzgvODE0R1NhUmFwcDNCL0IrczAxVG9PaTZXTHh6TzNhZ0ZsTEF0?=
 =?utf-8?B?UVJRb2w3cStOWlNEaEVxZTZwY1g1bStzUk5DbkliSWRySzlMeVNQdFlvTUl3?=
 =?utf-8?B?amVNSSs0c1RaaVhMTDNrbWV1T0wyaXNIUlRNM2VoNHNLQlY1SldRKzRaQmxI?=
 =?utf-8?B?V1dPQlMwU3RlQ3E4OFRTNy9KeGJyN2pYK0hGR1Y2NDZBNEZmUlQrYjd4c3hC?=
 =?utf-8?B?b3FIeVZoU1FRSTYrZXg4ejAxdWs1Q1cveVdFamh4MEhPZWEzeXBlaytlWFVa?=
 =?utf-8?B?NjcxUTNSdk5YWlE3ZTlKdklkZHV3cFJ6WFdmeUxFUGZFQm5YSXlYRnZzbmMw?=
 =?utf-8?B?MUpVN1l6THpHaStSc3NoK2FqQm0yaUU4RGlia0R1RVVyVXhRNGdydkVhNmh1?=
 =?utf-8?B?TFkreXpCMzMvaGQvRUowWks5R3JCS3ZmM2ZHMGRiUzVTRzg4QTEzOElGcUt5?=
 =?utf-8?B?SjF3UzZYVVdPSGljaTVXZ0Z4c2dvZ0R4WFd3WXB3MGZNam10dVprQ2VmSXlH?=
 =?utf-8?B?cDRRb2QrbCtTM3dISXNXcXJmN0w3d0oyMFo0MGIrTUg4ZGtwYUJNRHBvc1Bv?=
 =?utf-8?B?ZVp4cVIxZHRTaGdCeERxZTByNHZTb0gzL1FMc0Q1cWU3WHZYM2Uvc0lIV3B3?=
 =?utf-8?B?ZS9ZSGhOS3M4aWl5b2s5cmUxYS9wZDkrN0xJS2tUM3U0c2ZqRDlkb3J4VGdR?=
 =?utf-8?B?TE5YM2MzeG9NdXpXOERvN3Y1TGJSVHFpeG9lZEFleXE5UFNjWU0xRUdrZm9N?=
 =?utf-8?B?MnI1TTFKRjFPRSs4VFBqQXR6TUtUdlZqelIyMHppbHlvcU5wb3JtZHg2d3dC?=
 =?utf-8?Q?pGbgkJNdTB5g5weAH1F5PT4bhpoX2n6vgj85BkM?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb929574-1e2d-479d-97f9-08d9701140fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2021 02:02:45.5497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zOXe1YQnnNxp10/Y9fq2OvMaFnhSVnxZrdNDK2zxZFaoUZJW9P15kE6dH+VxXeJAbZMJOrcpQ1tofOzI8U2IoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4212
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10097 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109050013
X-Proofpoint-GUID: URvQ2KyhMKQ8_NS9AJz9EUVkkp_rKr1O
X-Proofpoint-ORIG-GUID: URvQ2KyhMKQ8_NS9AJz9EUVkkp_rKr1O
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQo+IE9uIFNlcCA0LCAyMDIxLCBhdCAxOjQxIFBNLCBNaWtlIEphdm9yc2tpIDxtaWtlLmphdm9y
c2tpQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiDvu79IaSBDaHVjay4NCj4gDQo+IEkgbm90aWNl
ZCB0aGF0IHlvdSBzZW50IGluIHRoZSA1LjE1IHB1bGwgcmVxdWVzdCBidXQgTmVpbCdzIGZpeA0K
PiAoZTM4YjNmMjAwNTk0MjZhMGFkYmRlMDE0ZmY3MTA3MTczOWFiNTIyNiBpbiB5b3VyIHRyZWUp
IG1pc3NlZCB0aGUNCj4gcHVsbCBhbmQgdGh1cyB0aGUgZml4IGlzbid0IGdvaW5nIHRvIGJlIGJh
Y2twb3J0ZWQgdG8gNS4xNCBpbiB0aGUgbmVhcg0KPiB0ZXJtLiBJcyB0aGVyZSBhbm90aGVyIDUu
MTUgcHVsbCBwbGFubmVkIGluIHRoZSBub3QgdG9vIGRpc3RhbnQgZnV0dXJlDQo+IHNvIHRoaXMg
d2lsbCBnZXQgZmxhZ2dlZCBmb3IgYmFjay1wb3J0aW5nLA0KDQpZZXMuIFRoZSBmaW5hbCB2ZXJz
aW9uIG9mIE5laWzigJlzIHBhdGNoIHdhcyBqdXN0IGEgbGl0dGxlIGxhdGUgZm9yIHRoZSBpbml0
aWFsIHY1LjE1IE5GU0QgcHVsbCByZXF1ZXN0IChJTU8pIHNvIGl04oCZcyBxdWV1ZWQgZm9yIHRo
ZSBuZXh0IFBSLCBwcm9iYWJseSB0aGlzIHdlZWsuDQoNCg0KPiBvciBkbyBJIG5lZWQgdG8gcmVh
Y2ggb3V0IHRvIHNvbWVvbmUgdG8gZXhwcmVzc2x5IHB1bGwgaXQgaW50byA1LjE0PyBJZiB0aGUg
bGF0dGVyLCBjYW4geW91DQo+IHBvaW50IG1lIGluIHRoZSByaWdodCBkaXJlY3Rpb24gb2Ygd2hv
IHRvIGFzayAoSSBhc3N1bWUgaXQncyBzb21lb25lDQo+IG90aGVyIHRoYW4gR3JlZyBLSCk/DQo+
IA0KPiBUaGFua3MNCj4gDQo+IC0gbWlrZQ0KPiANCj4gDQo+PiBPbiBTYXQsIEF1ZyAyOCwgMjAy
MSBhdCAxMToyMyBBTSBDaHVjayBMZXZlciBJSUkgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+IHdy
b3RlOg0KPj4gDQo+PiANCj4+IA0KPj4+PiBPbiBBdWcgMjcsIDIwMjEsIGF0IDExOjIyIFBNLCBN
aWtlIEphdm9yc2tpIDxtaWtlLmphdm9yc2tpQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4g
SSBoYWQgc29tZSB0aW1lIHRoaXMgZXZlbmluZyAoYW5kIHRoZSBrZXJuZWwgZmluYWxseSBjb21w
aWxlZCksIGFuZA0KPj4+IHdhbnRlZCB0byBnZXQgdGhpcyB0ZXN0ZWQuDQo+Pj4gDQo+Pj4gVGhl
IFRMO0RSOiAgQm90aCBwYXRjaGVzIGFyZSBuZWVkZWQNCj4+PiANCj4+PiBCZWxvdyBhcmUgdGhl
IHRlc3QgcmVzdWx0cyBmcm9tIG15IHJlcGxpY2F0aW9uIG9mIE5laWwncyB0ZXN0LiBJdCBpcw0K
Pj4+IHJlYWRpbHkgYXBwYXJlbnQgdGhhdCBib3RoIHRoZSA1LjEzLjEzIGtlcm5lbCBBTkQgdGhl
IDUuMTMuMTMga2VybmVsDQo+Pj4gd2l0aCB0aGUgODIwMTFjODBiM2VjIGZpeCBleGhpYml0IHRo
ZSByYW5kb21uZXNzIGluIHJlYWQgdGltZXMgdGhhdA0KPj4+IHdlcmUgb2JzZXJ2ZWQuIFRoZSA1
LjEzLjEzIGtlcm5lbCB3aXRoIGJvdGggdGhlIDgyMDExYzgwYjNlYyBhbmQNCj4+PiBmNmU3MGFh
YjlkZmUgZml4ZXMgYnJpbmdzIHRoZSBwZXJmb3JtYW5jZSBiYWNrIGluIGxpbmUgd2l0aCB0aGUN
Cj4+PiA1LjEyLjE1IGtlcm5lbCB3aGljaCBJIHRlc3RlZCBhcyBhIGJhc2VsaW5lLg0KPj4+IA0K
Pj4+IFBsZWFzZSBmb3JnaXZlIHRoZSBpbmNvbnNpc3RlbmN5IGluIHNhbXBsZSBjb3VudHMuIFRo
aXMgd2FzIHJ1bm5pbmcgYXMNCj4+PiBhIHdoaWxlIGxvb3AsIGFuZCBJIGp1c3QgbGV0IGl0IGdv
IGxvbmcgZW5vdWdoIHRoYXQgdGhlIGJlaGF2aW9yIHdhcw0KPj4+IGNvbnNpc3RlbnQuIE9ubHkg
Y2hhbmdlIHRvIHRoZSBWTSBiZXR3ZWVuIHRlc3RzIHdhcyB0aGUgZGlmZmVyZW50DQo+Pj4ga2Vy
bmVsICsgYSByZWJvb3QuIFRoZSB0ZXN0aW5nIFBDIGhhZCBhIGNvbnNpc3RlbnQgd29ya2xvYWQg
ZHVyaW5nIHRoZQ0KPj4+IGVudGlyZSBzZXQgb2YgdGVzdHMuDQo+Pj4gDQo+Pj4gVGVzdCAwOiA1
LjEzLjEwIChiYXNlIGtlcm5lbCBpbiBWTSBpbWFnZSwganVzdCBmb3Iga2lja3MpDQo+Pj4gPT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4+PiBTYW1w
bGVzIDMwDQo+Pj4gTWluIDYuODM5DQo+Pj4gTWF4IDE5Ljk5OA0KPj4+IE1lZGlhbiA5LjYzOA0K
Pj4+IDc1LVAgMTAuODk4DQo+Pj4gOTUtUCAxMi45MzkNCj4+PiA5OS1QIDE4LjAwNQ0KPj4+IA0K
Pj4+IFRlc3QgMTogNS4xMi4xNSAoa25vd24gZ29vZCkNCj4+PiA9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPj4+IFNhbXBsZXMgMTUyDQo+Pj4gTWlu
IDEuOTk3DQo+Pj4gTWF4IDIuMzMzDQo+Pj4gTWVkaWFuIDIuMTcxDQo+Pj4gNzUtUCAyLjIzMA0K
Pj4+IDk1LVAgMi4yODYNCj4+PiA5OS1QIDIuMzEyDQo+Pj4gDQo+Pj4gVGVzdCAyOiA1LjEzLjEz
IChrbm93biBiYWQpDQo+Pj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT0NCj4+PiBTYW1wbGVzIDQyDQo+Pj4gTWluIDMuNTg3DQo+Pj4gTWF4IDE1Ljgw
Mw0KPj4+IE1lZGlhbiA2LjAzOQ0KPj4+IDc1LVAgNi40NTINCj4+PiA5NS1QIDEwLjI5Mw0KPj4+
IDk5LVAgMTUuNTQwDQo+Pj4gDQo+Pj4gVGVzdCAzOiA1LjEzLjEzICsgODIwMTFjODBiM2VjIGZp
eA0KPj4+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
DQo+Pj4gU2FtcGxlcyA0NA0KPj4+IE1pbiA0LjMwOQ0KPj4+IE1heCAzNy4wNDANCj4+PiBNZWRp
YW4gNi42MTUNCj4+PiA3NS1QIDEwLjIyNA0KPj4+IDk1LVAgMTkuNTE2DQo+Pj4gOTktUCAzNi42
NTANCj4+PiANCj4+PiBUZXN0IDQ6IDUuMTMuMTMgKyA4MjAxMWM4MGIzZWMgZml4ICsgZjZlNzBh
YWI5ZGZlIGZpeA0KPj4+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09DQo+Pj4gU2FtcGxlcyAxMzENCj4+PiBNaW4gMi4wMTMNCj4+PiBNYXggMi4zOTcN
Cj4+PiBNZWRpYW4gMi4xNjkNCj4+PiA3NS1QIDIuMjExDQo+Pj4gOTUtUCAyLjI4Mw0KPj4+IDk5
LVAgMi4zNDgNCj4+PiANCj4+PiBJIGFtIGdvaW5nIHRvIHJ1biB0aGUga2VybmVsIHcvIGJvdGgg
Zml4ZXMgb3ZlciB0aGUgd2Vla2VuZCwgYnV0DQo+Pj4gdGhpbmdzIGxvb2sgZ29vZCBhdCB0aGlz
IHBvaW50Lg0KPj4+IA0KPj4+IC0gbWlrZQ0KPj4gDQo+PiBJJ3ZlIHRhcmdldGVkIE5laWwncyBm
aXggZm9yIHRoZSBmaXJzdCA1LjE1LXJjIE5GU0QgcHVsbCByZXF1ZXN0Lg0KPj4gSSdkIGxpa2Ug
dG8gaGF2ZSBNZWwncyBSZXZpZXdlZC1ieSBvciBBY2tlZC1ieSwgdGhvdWdoLg0KPj4gDQo+PiBJ
IHdpbGwgYWRkIGEgRml4ZXM6IHRhZyBpZiBOZWlsIGRvZXNuJ3QgcmVwb3N0IChubyByZWFzb24g
dG8gYXQNCj4+IHRoaXMgcG9pbnQpIHNvIHRoZSBmaXggc2hvdWxkIGdldCBiYWNrcG9ydGVkIGF1
dG9tYXRpY2FsbHkgdG8NCj4+IHJlY2VudCBzdGFibGUga2VybmVscy4NCj4+IA0KPj4gDQo+Pj4g
T24gRnJpLCBBdWcgMjcsIDIwMjEgYXQgNDo0OSBQTSBDaHVjayBMZXZlciBJSUkgPGNodWNrLmxl
dmVyQG9yYWNsZS5jb20+IHdyb3RlOg0KPj4+PiANCj4+Pj4gDQo+Pj4+PiBPbiBBdWcgMjcsIDIw
MjEsIGF0IDY6MDAgUE0sIE1pa2UgSmF2b3Jza2kgPG1pa2UuamF2b3Jza2lAZ21haWwuY29tPiB3
cm90ZToNCj4+Pj4+IA0KPj4+Pj4gT0ssIGFuIHVwZGF0ZS4gU2V2ZXJhbCBob3VycyBvZiBzcGFj
ZWQgb3V0IHRlc3Rpbmcgc2Vzc2lvbnMgYW5kIHRoZQ0KPj4+Pj4gZmlyc3QgcGF0Y2ggc2VlbXMg
dG8gaGF2ZSByZXNvbHZlZCB0aGUgaXNzdWUuIFRoZXJlIG1heSBiZSBhIHZlcnkgdGlueQ0KPj4+
Pj4gYml0IG9mIGxhZyB0aGF0IHN0aWxsIG9jY3VycyB3aGVuIG9wZW5pbmcvcHJvY2Vzc2luZyBu
ZXcgZmlsZXMsIGJ1dCBzbw0KPj4+Pj4gZmFyIG9uIHRoaXMga2VybmVsIEkgaGF2ZSBub3QgaGFk
IGFueSBtdWx0aS1zZWNvbmQgZnJlZXplcy4gSSBhbSBzdGlsbA0KPj4+Pj4gd2FpdGluZyBvbiB0
aGUga2VybmVsIHdpdGggTmVpbCdzIHBhdGNoIHRvIGNvbXBpbGUgKGNvbXBpbGluZyBvbiB0aGlz
DQo+Pj4+PiB1bmRlcnBvd2VyZWQgc2VydmVyIHNvIGl0J3MgdGFraW5nIHNldmVyYWwgaG91cnMp
LCBidXQgSSB0aGluayB0aGUNCj4+Pj4+IHRlc3RpbmcgdGhlcmUgd2lsbCBqdXN0IGJlIHRvIHNl
ZSBpZiBJIGNhbiBzaG93IGl0IHdvcmtzIHN0aWxsLCBhbmQNCj4+Pj4+IHRoZW4gdG8gdHJ5IGFu
ZCB0ZXN0IGluIGEgbWVtb3J5IGNvbnN0cmFpbmVkIFZNLiBUbyBzZWUgaWYgSSBjYW4NCj4+Pj4+
IHJlY3JlYXRlIE5laWwncyBleHBlcmltZW50LiBMaWtlbHkgd2lsbCBoYXZlIHRvIGRvIHRoaXMg
b3ZlciB0aGUNCj4+Pj4+IHdlZWtlbmQgZ2l2ZW4gdGhlIGtlcm5lbCBjb21waWxlIGRlbGF5ICsg
ZmlkZGxpbmcgd2l0aCBhIFZNLg0KPj4+PiANCj4+Pj4gVGhhbmtzIGZvciB5b3VyIHRlc3Rpbmch
DQo+Pj4+IA0KPj4+PiANCj4+Pj4+IENodWNrOiBJIGRvbid0IG1lYW4gdG8gb3ZlcnN0ZXAgYm91
bmRzLCBidXQgaXMgaXQgcG9zc2libGUgdG8gZ2V0IHRoYXQNCj4+Pj4+IHBhdGNoIHB1bGxlZCBp
bnRvIDUuMTMgc3RhYmxlPyBUaGF0IG1heSBoZWxwIHRoaW5ncyBmb3Igc2V2ZXJhbCBwZW9wbGUN
Cj4+Pj4+IHdoaWxlIDUuMTQgZ29lcyB0aHJvdWdoIGl0J3Mgc2hha2Vkb3duIGluIGFyY2hsaW51
eCBwcmlvciB0byByZWxlYXNlLg0KPj4+PiANCj4+Pj4gVGhlIHBhdGNoIGhhZCBhIEZpeGVzOiB0
YWcsIHNvIGl0IHNob3VsZCBnZXQgYXV0b21hdGljYWxseSBiYWNrcG9ydGVkDQo+Pj4+IHRvIGV2
ZXJ5IGtlcm5lbCB0aGF0IGhhcyB0aGUgYnJva2VuIGNvbW1pdC4gSWYgeW91IGRvbid0IHNlZSBp
dCBpbg0KPj4+PiBhIHN1YnNlcXVlbnQgNS4xMyBzdGFibGUga2VybmVsLCB5b3UgYXJlIGZyZWUg
dG8gYXNrIHRoZSBzdGFibGUNCj4+Pj4gbWFpbnRhaW5lcnMgdG8gY29uc2lkZXIgaXQuDQo+Pj4+
IA0KPj4+PiANCj4+Pj4+IC0gbWlrZQ0KPj4+Pj4gDQo+Pj4+PiBPbiBGcmksIEF1ZyAyNywgMjAy
MSBhdCAxMDowNyBBTSBNaWtlIEphdm9yc2tpIDxtaWtlLmphdm9yc2tpQGdtYWlsLmNvbT4gd3Jv
dGU6DQo+Pj4+Pj4gDQo+Pj4+Pj4gQ2h1Y2s6DQo+Pj4+Pj4gSSBqdXN0IGJvb3RlZCBhIDUuMTMu
MTMga2VybmVsIHdpdGggeW91ciBzdWdnZXN0ZWQgcGF0Y2guIE5vIGZyZWV6ZXMNCj4+Pj4+PiBv
biB0aGUgZmlyc3QgdGVzdCwgYnV0IHRoYXQgc29tZXRpbWVzIGhhcHBlbnMgc28gSSB3aWxsIGxl
dCB0aGUgc2VydmVyDQo+Pj4+Pj4gc2V0dGxlIHNvbWUgYW5kIHRyeSBpdCBhZ2FpbiBsYXRlciBp
biB0aGUgZGF5ICh3aGljaCBhbHNvIHdvdWxkIGFsaWduDQo+Pj4+Pj4gd2l0aCBOZWlsJ3MgY29t
bWVudCBvbiBtZW1vcnkgZnJhZ21lbnRhdGlvbiBiZWluZyBhIGNvbnRyaWJ1dG9yKS4NCj4+Pj4+
PiANCj4+Pj4+PiBOZWlsOg0KPj4+Pj4+IEkgaGF2ZSBzdGFydGVkIGEgY29tcGlsZSB3aXRoIHRo
ZSBhYm92ZSBrZXJuZWwgKyB5b3VyIHBhdGNoIHRvIHRlc3QNCj4+Pj4+PiBuZXh0IHVubGVzcyB5
b3Ugb3IgQ2h1Y2sgZGV0ZXJtaW5lIHRoYXQgaXQgaXNuJ3QgbmVlZGVkLCBvciB0aGF0IEkNCj4+
Pj4+PiBzaG91bGQgdGVzdCBib3RoIHBhdGNoZXMgZGlzY3JlZXRseS4gQXMgdGhlIGFib3ZlIGlz
IGFscmVhZHkgbWVyZ2VkIHRvDQo+Pj4+Pj4gNS4xNCBpdCBzZWVtZWQgbG9naWNhbCB0byBqdXN0
IGFkZCB5b3VyIHBhdGNoIG9uIHRvcC4NCj4+Pj4+PiANCj4+Pj4+PiBJIHdpbGwgYWxzbyB0cnkg
dG8gc2V0IHVwIGEgdm0gdG8gdGVzdCB5b3VyIG1kNXN1bSBzY2VuYXJpbyB3aXRoIHRoZQ0KPj4+
Pj4+IHZhcmlvdXMga2VybmVscyBzaW5jZSBpdCdzIGEgbXVjaCBmYXN0ZXIgdGhpbmcgdG8gdGVz
dC4NCj4+Pj4+PiANCj4+Pj4+PiAtIG1pa2UNCj4+Pj4+PiANCj4+Pj4+PiBPbiBGcmksIEF1ZyAy
NywgMjAyMSBhdCA3OjEzIEFNIENodWNrIExldmVyIElJSSA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNv
bT4gd3JvdGU6DQo+Pj4+Pj4+IA0KPj4+Pj4+PiANCj4+Pj4+Pj4+IE9uIEF1ZyAyNywgMjAyMSwg
YXQgMzoxNCBBTSwgTmVpbEJyb3duIDxuZWlsYkBzdXNlLmRlPiB3cm90ZToNCj4+Pj4+Pj4+IA0K
Pj4+Pj4+Pj4gU3ViamVjdDogW1BBVENIXSBTVU5SUEM6IGRvbid0IHBhdXNlIG9uIGluY29tcGxl
dGUgYWxsb2NhdGlvbg0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBhbGxvY19wYWdlc19idWxrX2FycmF5
KCkgYXR0ZW1wdHMgdG8gYWxsb2NhdGUgYXQgbGVhc3Qgb25lIHBhZ2UgYmFzZWQgb24NCj4+Pj4+
Pj4+IHRoZSBwcm92aWRlZCBwYWdlcywgYW5kIHRoZW4gb3Bwb3J0dW5pc3RpY2FsbHkgYWxsb2Nh
dGVzIG1vcmUgaWYgdGhhdA0KPj4+Pj4+Pj4gY2FuIGJlIGRvbmUgd2l0aG91dCBkcm9wcGluZyB0
aGUgc3BpbmxvY2suDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+IFNvIGlmIGl0IHJldHVybnMgZmV3ZXIg
dGhhbiByZXF1ZXN0ZWQsIHRoYXQgY291bGQganVzdCBtZWFuIHRoYXQgaXQNCj4+Pj4+Pj4+IG5l
ZWRlZCB0byBkcm9wIHRoZSBsb2NrLiAgSW4gdGhhdCBjYXNlLCB0cnkgYWdhaW4gaW1tZWRpYXRl
bHkuDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+IE9ubHkgcGF1c2UgZm9yIGEgdGltZSBpZiBubyBwcm9n
cmVzcyBjb3VsZCBiZSBtYWRlLg0KPj4+Pj4+PiANCj4+Pj4+Pj4gVGhlIGNhc2UgSSB3YXMgd29y
cmllZCBhYm91dCB3YXMgIm5vIHBhZ2VzIGF2YWlsYWJsZSBvbiB0aGUNCj4+Pj4+Pj4gcGNwbGlz
dCIsIGluIHdoaWNoIGNhc2UsIGFsbG9jX3BhZ2VzX2J1bGtfYXJyYXkoKSByZXNvcnRzDQo+Pj4+
Pj4+IHRvIGNhbGxpbmcgX19hbGxvY19wYWdlcygpIGFuZCByZXR1cm5zIG9ubHkgb25lIG5ldyBw
YWdlLg0KPj4+Pj4+PiANCj4+Pj4+Pj4gIk5vIHByb2dlc3MiIHdvdWxkIG1lYW4gZXZlbiBfX2Fs
bG9jX3BhZ2VzKCkgZmFpbGVkLg0KPj4+Pj4+PiANCj4+Pj4+Pj4gU28gdGhpcyBwYXRjaCB3b3Vs
ZCBiZWhhdmUgZXNzZW50aWFsbHkgbGlrZSB0aGUNCj4+Pj4+Pj4gcHJlLWFsbG9jX3BhZ2VzX2J1
bGtfYXJyYXkoKSBjb2RlOiBjYWxsIGFsbG9jX3BhZ2UoKSBmb3INCj4+Pj4+Pj4gZWFjaCBlbXB0
eSBzdHJ1Y3RfcGFnZSBpbiB0aGUgYXJyYXkgd2l0aG91dCBwYXVzaW5nLiBUaGF0DQo+Pj4+Pj4+
IHNlZW1zIGNvcnJlY3QgdG8gbWUuDQo+Pj4+Pj4+IA0KPj4+Pj4+PiANCj4+Pj4+Pj4gSSB3b3Vs
ZCBhZGQNCj4+Pj4+Pj4gDQo+Pj4+Pj4+IEZpeGVzOiBmNmU3MGFhYjlkZmUgKCJTVU5SUEM6IHJl
ZnJlc2ggcnFfcGFnZXMgdXNpbmcgYSBidWxrIHBhZ2UgYWxsb2NhdG9yIikNCj4+Pj4+Pj4gDQo+
Pj4+Pj4+IA0KPj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogTmVpbEJyb3duIDxuZWlsYkBzdXNlLmRl
Pg0KPj4+Pj4+Pj4gLS0tDQo+Pj4+Pj4+PiBuZXQvc3VucnBjL3N2Y194cHJ0LmMgfCA3ICsrKysr
LS0NCj4+Pj4+Pj4+IDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+IGRpZmYgLS1naXQgYS9uZXQvc3VucnBjL3N2Y194cHJ0
LmMgYi9uZXQvc3VucnBjL3N2Y194cHJ0LmMNCj4+Pj4+Pj4+IGluZGV4IGQ2NmE4ZTQ0YTFhZS4u
OTkyNjhkZDk1NTE5IDEwMDY0NA0KPj4+Pj4+Pj4gLS0tIGEvbmV0L3N1bnJwYy9zdmNfeHBydC5j
DQo+Pj4+Pj4+PiArKysgYi9uZXQvc3VucnBjL3N2Y194cHJ0LmMNCj4+Pj4+Pj4+IEBAIC02NjIs
NyArNjYyLDcgQEAgc3RhdGljIGludCBzdmNfYWxsb2NfYXJnKHN0cnVjdCBzdmNfcnFzdCAqcnFz
dHApDQo+Pj4+Pj4+PiB7DQo+Pj4+Pj4+PiAgICBzdHJ1Y3Qgc3ZjX3NlcnYgKnNlcnYgPSBycXN0
cC0+cnFfc2VydmVyOw0KPj4+Pj4+Pj4gICAgc3RydWN0IHhkcl9idWYgKmFyZyA9ICZycXN0cC0+
cnFfYXJnOw0KPj4+Pj4+Pj4gLSAgICAgdW5zaWduZWQgbG9uZyBwYWdlcywgZmlsbGVkOw0KPj4+
Pj4+Pj4gKyAgICAgdW5zaWduZWQgbG9uZyBwYWdlcywgZmlsbGVkLCBwcmV2Ow0KPj4+Pj4+Pj4g
DQo+Pj4+Pj4+PiAgICBwYWdlcyA9IChzZXJ2LT5zdl9tYXhfbWVzZyArIDIgKiBQQUdFX1NJWkUp
ID4+IFBBR0VfU0hJRlQ7DQo+Pj4+Pj4+PiAgICBpZiAocGFnZXMgPiBSUENTVkNfTUFYUEFHRVMp
IHsNCj4+Pj4+Pj4+IEBAIC02NzIsMTEgKzY3MiwxNCBAQCBzdGF0aWMgaW50IHN2Y19hbGxvY19h
cmcoc3RydWN0IHN2Y19ycXN0ICpycXN0cCkNCj4+Pj4+Pj4+ICAgICAgICAgICAgcGFnZXMgPSBS
UENTVkNfTUFYUEFHRVM7DQo+Pj4+Pj4+PiAgICB9DQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+IC0gICAg
IGZvciAoOzspIHsNCj4+Pj4+Pj4+ICsgICAgIGZvciAocHJldiA9IDA7OyBwcmV2ID0gZmlsbGVk
KSB7DQo+Pj4+Pj4+PiAgICAgICAgICAgIGZpbGxlZCA9IGFsbG9jX3BhZ2VzX2J1bGtfYXJyYXko
R0ZQX0tFUk5FTCwgcGFnZXMsDQo+Pj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgcnFzdHAtPnJxX3BhZ2VzKTsNCj4+Pj4+Pj4+ICAgICAgICAgICAgaWYg
KGZpbGxlZCA9PSBwYWdlcykNCj4+Pj4+Pj4+ICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4+
Pj4+Pj4+ICsgICAgICAgICAgICAgaWYgKGZpbGxlZCA+IHByZXYpDQo+Pj4+Pj4+PiArICAgICAg
ICAgICAgICAgICAgICAgLyogTWFkZSBwcm9ncmVzcywgZG9uJ3Qgc2xlZXAgeWV0ICovDQo+Pj4+
Pj4+PiArICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+
ICAgICAgICAgICAgc2V0X2N1cnJlbnRfc3RhdGUoVEFTS19JTlRFUlJVUFRJQkxFKTsNCj4+Pj4+
Pj4+ICAgICAgICAgICAgaWYgKHNpZ25hbGxlZCgpIHx8IGt0aHJlYWRfc2hvdWxkX3N0b3AoKSkg
ew0KPj4+Pj4+PiANCj4+Pj4+Pj4gLS0NCj4+Pj4+Pj4gQ2h1Y2sgTGV2ZXINCj4+Pj4+Pj4gDQo+
Pj4+Pj4+IA0KPj4+Pj4+PiANCj4+Pj4gDQo+Pj4+IC0tDQo+Pj4+IENodWNrIExldmVyDQo+Pj4+
IA0KPj4+PiANCj4+Pj4gDQo+PiANCj4+IC0tDQo+PiBDaHVjayBMZXZlcg0KPj4gDQo+PiANCj4+
IA0K
